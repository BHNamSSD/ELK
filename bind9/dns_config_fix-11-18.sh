#!/bin/bash
#
#
#
#
#
#fuction question
function ask_continue() {
	
	echo "Do you want $1(y/n): "
	read answer
	case $answer in
		[yY])
			echo "Continue..."
			return 0
			;;
		[nN])
			echo "End..."
			exit 1
			;;
		*)
			echo "invalid"
			ask_continue
			;;

	esac
}


# Kiểm tra quyền root
if [ "$(id -u)" -ne 0 ]; then
    #echo "Vui lòng chạy script với quyền root!"
    echo "Please run file with permission root!"
    exit 1
fi

# Nhập tên miền và IP
#read -p "Nhập tên miền (vd: example.com): " DOMAIN
read -p "Enter name your domain(example: domain.com): " DOMAIN

#read -p "Nhập địa chỉ IP máy chủ DNS: " DNS_IP
read -p "Enter address of DNS server: " DNS_IP

#read -p "Nhập địa chỉ IP cho www: " WWW_IP
read -p "Enter address of www: " WWW_IP

#read -p "Nhập địa chỉ IP cho mail: " MAIL_IP
read -p "Enter address of mail: " MAIL_IP

ask_continue "install bind9"


# Cài đặt Bind9 nếu chưa có
#echo "Cài đặt Bind9..."
echo "installing Bind9.."
apt update && apt install bind9 bind9utils bind9-doc -y

#ask_continue

#khoi dong xem tinh trang
systemctl restart bind9
systemctl status bind9


ask_continue "config file named.conf.options->"

# Tạo thư mục zones nếu chưa có
ZONES_DIR="/etc/bind/zones"
mkdir -p $ZONES_DIR



# Cấu hình tùy chọn trong named.conf.options
cp /etc/bind/named.conf.options /etc/bind/named.conf.options.old

OPTIONS_FILE="/etc/bind/named.conf.options"
if ! grep -q "recursion yes;" $OPTIONS_FILE; then
    #sed -i '/^options {/a \\trecursion yes;\n\tallow-query { any; };\n\t#DNS servers\n\tforwarders { 8.8.8.8; 1.1.1.1; };\n\tlisten-on { $DNS_IP; };' $OPTIONS_FILE
	sed -i "/^options {/a \\
    recursion yes;\\
    allow-query { any; };\\
    #DNS servers\\
    forwarders { 8.8.8.8; 1.1.1.1; };\\
    listen-on { $DNS_IP; };" $OPTIONS_FILE
fi

named-checkconf $OPTIONS_FILE
ask_continue "create zone file->"

# Tạo tệp vùng (Forward Zone)
ZONE_FILE="$ZONES_DIR/db.$DOMAIN"
cat > $ZONE_FILE <<EOF
\$TTL	604800
@	IN	SOA	$DOMAIN. root.$DOMAIN. (
	$(date +%Y%m%d01) ; Serial
	604800           ; Refresh
	86400            ; Retry
	2419200          ; Expire
	604800 )         ; Negative Cache TTL

; Name Server
@	IN	NS	dns.$DOMAIN.

; A Records
dns	IN	A	$DNS_IP
www	IN	A	$WWW_IP
mail	IN	A	$MAIL_IP
;@	IN  AAAA ::1

; MX Records
;@       IN  MX  10 mail.$DOMAIN.

; TXT Record
;@       IN  TXT "v=spf1 include:$DOMAIN ~all"
EOF

#named-checkzone $ZONE_FILE $ZONE_FILE
#ask_continue "create reverse zone file->"


# Tạo tệp vùng Reverse Zone
REVERSE_ZONE=$(echo $DNS_IP | awk -F. '{print $3"."$2"."$1".in-addr.arpa"}')
REVERSE_FILE="$ZONES_DIR/db.reverse.$DOMAIN"
cat > $REVERSE_FILE <<EOF
\$TTL	604800
@	IN	SOA $DOMAIN. root.$DOMAIN. (
	$(date +%Y%m%d01) ; Serial
	604800           ; Refresh
	86400            ; Retry
	2419200          ; Expire
	604800 )         ; Negative Cache TTL

; Name Server
@	IN	NS	dns.$DOMAIN.

; PTR Records
$(echo $DNS_IP | awk -F. '{print $4}')	IN	PTR	dns.$DOMAIN.
$(echo $WWW_IP | awk -F. '{print $4}')	IN	PTR	www.$DOMAIN.
$(echo $MAIL_IP | awk -F. '{print $4}')	IN	PTR	mail.$DOMAIN.
EOF

#named-checkzone $REVERSE_FILE $REVERSE_FILE
#ask_continue "config named.conf.local->"

# Cập nhật tệp named.conf.local
NAMED_LOCAL="/etc/bind/named.conf.local"
cat >> $NAMED_LOCAL <<EOF

zone "$DOMAIN" {
    type master;
    file "$ZONE_FILE";
};

zone "$REVERSE_ZONE" {
    type master;
    file "$REVERSE_FILE";
};
EOF

named-checkconf $NAMED_LOCAL
ask_continue "check config all->"


# Kiểm tra cấu hình và khởi động lại Bind9
#echo "Kiểm tra cấu hình..."
echo "Check config..."

named-checkconf


#ack_continue "Check domain, zone_file"
#named-checkzone $DOMAIN $ZONE_FILE

#ack_continue "Check reverse_zone, reverse_file"
#named-checkzone $REVERSE_ZONE $REVERSE_FILE

#echo "Khởi động lại Bind9..."
echo "Restart bind9..."
systemctl restart bind9
systemctl status bind9

#echo "Cấu hình hoàn tất!"
echo "Configuration complete!"

#echo "Máy chủ DNS đang hoạt động cho $DOMAIN với IP $DNS_IP"
echo "DNS server active for dns.$DOMAIN with IP $DNS_IP"




