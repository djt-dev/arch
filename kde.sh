#!/usr/bin/env bash

pacman -S noto-fonts noto-fonts-cjk noto-fonts-extra xorg plasma sddm plasma-meta kate konsole yakuake zsh aria2 wget proxychains v2ray --noconfirm

yay -S jdk maven --noconfirm

sed -i 's/#proxy_dns/proxy_dns/g' /etc/proxychains.conf
echo "socks5 127.0.0.1 1080" >> /etc/proxychains.conf

touch /lib/systemd/system/v2ray.service << BLOCK
[Unit]
Description=V2Ray Service
Documentation=https://www.v2fly.org/
After=network.target nss-lookup.target

[Service]
User=nobody
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/bin/v2ray -config /etc/v2ray/config.json
Restart=on-failure
RestartPreventExitStatus=23

[Install]
WantedBy=multi-user.target
BLOCK

#v2ray配置文件 还未配置



sudo systemctl enable sddm

