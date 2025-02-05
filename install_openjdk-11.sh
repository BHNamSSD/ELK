



if [ "$(id -u)" -ne 0 ]; then
	echo "please run with root!"
	exit 1
fi


sudo apt update
sudo apt-get update

sudo apt-get install apt-transport-https
sudo apt install openjdk-11-jdk -y

java --version




