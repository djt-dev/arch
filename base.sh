#!/usr/bin/env bash

ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
timedatectl set-ntp true
hwclock --systohc


sed -i 's/\#en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen
sed -i 's/\#zh_CN.UTF-8/zh_CN.UTF-8/' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

echo "arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts

echo root:qwe123|chpaswd

cp /etc/pacman.conf /etc/pacman.conf.back
sed -i 's/\#ParallelDownloads = /ParallelDownloads = 5' /etc/pacman.conf
#echo "[archlinuxcn]" >>/etc/pacman.conf
#echo "Server = https://mirrors.aliyun.com/archlinuxcn/\$arch" >> /etc/pacman.conf

pacman -S --noconfirm grub efibootmgr networkmanager bash-completion dialog
base-devel linux-headers xdg-user-dirs

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=ARCH
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager

useradd -m djt
echo djt:qwe123 | chpasswd
useradd -aG wheel djt
echo "djt ALL=(ALL) ALL" >> /etc/sudoers.d/djt
