#!/bin/bash

# === Cấu hình người dùng proxy ===
USERNAME="Vessy"
PASSWORD="Thynerss123"

# === Cài đặt Dante ===
apt update
apt install -y dante-server

# === Tạo user proxy (nếu chưa tồn tại) ===
id -u $USERNAME &>/dev/null || useradd -r -s /usr/sbin/nologin $USERNAME
echo "$USERNAME:$PASSWORD" | chpasswd

# === Tạo file log ===
touch /var/log/danted.log
chown nobody:nogroup /var/log/danted.log

# === Ghi file cấu hình ===
cat > /etc/danted.conf <<EOF
logoutput: /var/log/danted.log

internal: eth0 port = 1080
external: eth0

method: username
user.notprivileged: nobody

client pass {
    from: 0.0.0.0/0 to: 0.0.0.0/0
    log: connect disconnect
}

socks pass {
    from: 0.0.0.0/0 to: 0.0.0.0/0
    command: connect
    log: connect disconnect
}
EOF

# === Mở port 1080 nếu dùng UFW ===
if command -v ufw &>/dev/null; then
    ufw allow 1080/tcp
fi

# === Bật và khởi động dịch vụ ===
systemctl enable danted
systemctl restart danted

# === Kết quả ===
echo
echo "✅ SOCKS5 proxy đã được cài đặt và chạy!"
echo "🔗 Proxy: $(curl -s ifconfig.me):1080"
echo "👤 User: $USERNAME"
echo "🔒 Pass: $PASSWORD"
