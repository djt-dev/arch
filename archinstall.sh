#!/usr/bin/env bash

cat mirrorlist >> /etc/pacman.d/mirrorlist


pacstrap /mnt base base-devel linux linux-firmware bash-completion vim reflector grub efibootmgr
genfstab -U /mnt/>>/etc/fstab
arch-chroot /mnt
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

sed -i 's/#zh_CN.U/zh_CN.U/g' /etc/locale.gen
sed -i 's/#en_US.U/en_US.U/g' /etc/locale.gen
locale-gen

useradd -mG wheel djt
sed -i 's/# %whell/ %wheel/g' /etc/sudoers
chpasswd<<EOF
root:qwe123
djt:qwe123
EOF

systemctl enable NetworkManager

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=arch
grub-mkconfig -o /boot/grub/grub.cfg
exit
umount -R /mnt
reboot


