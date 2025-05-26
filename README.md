# Hướng Dẫn Cài Đặt SOCKS5 Proxy Có Xác Thực Username/Password

Script này giúp bạn tự động cài đặt và cấu hình SOCKS5 Proxy (sử dụng Dante) trên VPS Linux (Ubuntu/Debian), có xác thực bằng username/password.

Yêu cầu: có 1 con VPS nước ngoài thì ngon, không có thì thuê 1 con để dành xài

## Yêu Cầu

- VPS chạy hệ điều hành Ubuntu hoặc Debian.
- Có quyền root (sudo).
- Đã mở port 1080 trên firewall (script sẽ tự mở nếu dùng UFW).

## Các Bước Thực Hiện

### 1. Tải Script về VPS

```bash
git clone https://github.com/mhqb365/socket5.git
cd socket5
```

Hoặc tải trực tiếp file `setup.sh` về VPS:

```bash
wget https://raw.githubusercontent.com/mhqb365/socket5/master/setup.sh
chmod +x setup.sh
```

### 2. Phân Quyền Thực Thi

```bash
chmod +x setup.sh
```

### 3. Chạy Script

```bash
sudo ./setup.sh
```

### 4. Thông Tin Proxy

Sau khi chạy xong, script sẽ hiển thị:

- Địa chỉ IP proxy
- Port: 1080
- Username và Password (mặc định: `proxyuser` / `StrongPass123!`)

Bạn có thể thay đổi username/password bằng cách sửa biến `USERNAME` và `PASSWORD` ở đầu file `setup.sh`.

### 5. Kết Nối Proxy

Cấu hình trình duyệt, phần mềm, hoặc hệ điều hành sử dụng SOCKS5 proxy với thông tin:

- Host: IP VPS của bạn
- Port: 1080
- Username: proxyuser
- Password: StrongPass123!

### 6. Quản Lý Proxy

- **Xem log:**  
  `tail -f /var/log/danted.log`
- **Khởi động lại proxy:**  
  `sudo systemctl restart danted`
- **Dừng proxy:**  
  `sudo systemctl stop danted`
- **Kiểm tra trạng thái:**  
  `sudo systemctl status danted`

## Lưu Ý

- Đổi mật khẩu mặc định sau khi cài đặt để đảm bảo an toàn.
- Nếu VPS có nhiều card mạng, chỉnh lại dòng `internal` và `external` trong `/etc/danted.conf` cho phù hợp.
- Script chỉ hỗ trợ hệ điều hành Ubuntu/Debian.

## Gỡ Cài Đặt

```bash
sudo apt remove --purge dante-server -y
sudo rm -f /etc/danted.conf /var/log/danted.log
sudo userdel proxyuser
```

---

**Mọi thắc mắc hoặc góp ý, vui lòng tạo issue trên GitHub!**