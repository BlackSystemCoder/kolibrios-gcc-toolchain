#!/bin/bash

# Written by turbocat2001 (Maxim Logaev)
# Installation steps described by maxcodehack (Maxim Kuzmitsky)
# modified by Egor00f (Egor)

set -e

print_msg(){
	echo -e "\e[34m$1\e[0m"
}

print_ok(){
	echo -e "\e[32m$1\e[0m"
}

print_err(){
	echo -e "\e[31m$1\e[0m"
	exit
}

check_utils(){
	printf "%s: " $1
	if command -v $1 &> /dev/null
	then
		print_ok "ok\r"
	else
		print_err "no\r"
	fi
}

pwd

DEFAULT_TOOLCHAIN_DIR="/home/autobuild/tools"

TOOLCHAIN_DIR=$DEFAULT_TOOLCHAIN_DIR

MESSAGE="Toolchain install path(default is $TOOLCHAIN_DIR): "

echo -n $MESSAGE
read INPUT

if [[ ! -z "$INPUT" ]]; then
	TOOLCHAIN_DIR=$INPUT
fi

echo "Installing toolchain to $TOOLCHAIN_DIR"


print_msg "Checking utilities..."



check_utils wget
check_utils 7z



print_msg "Create the toolchain folders..."

sudo mkdir -p $DEFAULT_TOOLCHAIN_DIR
sudo mkdir -p $TOOLCHAIN_DIR

print_ok "Successfully!"



print_msg "Download the kos32-gcc toolchain..."

sudo wget http://ftp.kolibrios.org/users/Serge/new/Toolchain/x86_64-linux-kos32-5.4.0.7z -q -O $TOOLCHAIN_DIR/kos32-toolchain.7z

print_ok "Successfully!"



print_msg "Extracting files ..."

cd $TOOLCHAIN_DIR
sudo 7z x -y kos32-toolchain.7z
sudo rm -rf kos32-toolchain.7z

print_ok "Successfully!"



print_msg "Downloading libraries..."

cd $TOOLCHAIN_DIR/win32/mingw32
sudo wget http://ftp.kolibrios.org/users/Serge/new/Toolchain/sdk-28-10-16.7z -q -O sdk-28-10-16.7z
sudo 7z x -y sdk-28-10-16.7z
sudo rm -rf sdk-28-10-16.7z

print_ok "Successfully!"



print_msg "Updating libraries"

cd lib
sudo wget -r --no-parent -q http://builds.kolibrios.org/en_US/data/contrib/sdk/lib
mv builds.kolibrios.org/en_US/data/contrib/sdk/lib/* ./
rm -R builds.kolibrios.org

print_ok "Successfully!"



print_msg "Downloading libisl..."

cd /tmp
sudo wget http://board.kolibrios.org/download/file.php?id=8301libisl.so.10.2.2.7z -q -O /tmp/libisl.so.10.2.2.7z
sudo 7z x -y libisl.so.10.2.2.7z

if ! [ -d /usr/lib/x86_64-linux-gnu/ ]; then
	sudo mkdir -p /usr/lib/x86_64-linux-gnu/
fi

sudo mv /tmp/libisl.so.10.2.2 /usr/lib/x86_64-linux-gnu/libisl.so.10.2.2
sudo ln -sf /usr/lib/x86_64-linux-gnu/libisl.so.10.2.2 /usr/lib/x86_64-linux-gnu/libisl.so.10
sudo ln -sf /usr/lib/x86_64-linux-gnu/libisl.so.10.2.2 /usr/lib/libisl.so.10
sudo chmod go-w /usr/lib/x86_64-linux-gnu/libisl.so.10 
sudo chmod go-w /usr/lib/x86_64-linux-gnu/libisl.so.10.2.2

print_ok "Successfully!"


print_msg "Fixing libmpfr..."

sudo ln -sf /usr/lib/x86_64-linux-gnu/libmpfr.so.6 /usr/lib/x86_64-linux-gnu/libmpfr.so.4
sudo ln -sf /usr/lib/libmpfr.so.6 /usr/lib/libmpfr.so.4

print_ok "Successfully!"


if [ "$TOOLCHAIN_DIR" != "$DEFAULT_TOOLCHAIN_DIR" ]; then
	sudo ln -sf $TOOLCHAIN_DIR/win32 $DEFAULT_TOOLCHAIN_DIR
fi


MESSAGE="PATH=\$PATH:$TOOLCHAIN_DIR/win32/bin"

EXPORT_MESSSAGE="export $MESSAGE"

if [ ! "$(id -u)" -ne 0 ]
then
	echo $MESSAGE >> /etc/profile

	sudo mkdir -p /etc/kos32-gcc
	echo $TOOLCHAIN_DIR > /etc/kos32-gcc/install-path
else
	if ! grep -q $EXPORT_MESSSAGE ~/.bashrc; then
		print_msg "Adding '$TOOLCHAIN_DIR/win32/bin' to '~/.bashrc'"
		echo '$EXPORT_MESSSAGE' >> ~/.bashrc
	fi
fi

sudo chmod 775 $TOOLCHAIN_DIR/win32/bin/*
sudo chmod 775 $TOOLCHAIN_DIR/win32/include/*
sudo chmod -R 775 $TOOLCHAIN_DIR/win32/lib/gcc/mingw32/5.4.0/include


cd "$OLDPWD"

export PATH=$PATH:$TOOLCHAIN_DIR/win32/bin

print_ok "Installation was successful!"
