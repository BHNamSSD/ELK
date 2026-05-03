if [ "$(id -u)" -ne 0 ]; then
        echo "please run this file with root!"
        exit 1

fi

timedatectl status

timedatectl set-timezone Asia/Ho_Chi_Minh

sudo systemctl enable --now systemd-timesyncd

sudo systemctl status systemd-timesyncd

date

timedatectl status




