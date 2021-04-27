#!/usr/bin/env bash

cat << EOF >> /etc/pacman.d/mirrorlist
Server = https://mirrors.sjtug.sjtu.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.dgut.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.bfsu.edu.cn/archlinux/$repo/os/$arch
Server = http://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch
Server = http://mirrors.cqu.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.hit.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.cqu.edu.cn/archlinux/$repo/os/$arch
Server = rsync://rsync.mirrors.ustc.edu.cn/archlinux/$repo/os/$arch
Server = http://mirrors.zju.edu.cn/archlinux/$repo/os/$arch
Server = http://mirror.lzu.edu.cn/archlinux/$repo/os/$arch
Server = http://mirrors.dgut.edu.cn/archlinux/$repo/os/$arch
EOF

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


