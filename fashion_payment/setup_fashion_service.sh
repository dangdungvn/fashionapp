#!/bin/bash
# filepath: d:\Workspace\flutter\fullstack-fashionapp\fashion_payment\setup_fashion_service.sh

# Script để cài đặt và quản lý Fashion Payment Service trên Azure VM

# Đảm bảo chạy với quyền sudo
if [ "$(id -u)" -ne 0 ]; then
    echo "Vui lòng chạy script này với quyền sudo"
    exit 1
fi

# Thư mục hiện tại
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SERVICE_NAME="fashion-payment"
SERVICE_FILE="$SERVICE_NAME.service"
NODE_PATH=$(which node)

# Thiết lập quyền thực thi cho script chạy server
chmod +x "$SCRIPT_DIR/run_azure_server.js"

# Cập nhật nội dung file service
cat > "/etc/systemd/system/$SERVICE_FILE" << EOL
[Unit]
Description=Fashion Payment Node.js Server
After=network.target

[Service]
User=$(whoami)
Group=$(whoami)
WorkingDirectory=$SCRIPT_DIR
ExecStart=$NODE_PATH $SCRIPT_DIR/run_azure_server.js start
ExecStop=$NODE_PATH $SCRIPT_DIR/run_azure_server.js stop
Restart=on-failure
RestartSec=5s

[Install]
WantedBy=multi-user.target
EOL

echo "Đã tạo file service tại /etc/systemd/system/$SERVICE_FILE"

# Reload systemd để cập nhật thông tin service
systemctl daemon-reload

# Enable service để tự động khởi động khi boot
systemctl enable $SERVICE_NAME
echo "Đã enable service $SERVICE_NAME để tự khởi động khi boot"

# Menu chức năng
echo ""
echo "==== FASHION PAYMENT SERVICE MANAGER ===="
echo "1. Khởi động service"
echo "2. Dừng service"
echo "3. Kiểm tra trạng thái"
echo "4. Xem log"
echo "5. Thoát"
echo "========================================"
echo ""

read -p "Chọn chức năng (1-5): " choice

case $choice in
    1)
        echo "Đang khởi động service..."
        systemctl start $SERVICE_NAME
        sleep 2
        systemctl status $SERVICE_NAME
        ;;
    2)
        echo "Đang dừng service..."
        systemctl stop $SERVICE_NAME
        ;;
    3)
        echo "Trạng thái service:"
        systemctl status $SERVICE_NAME
        ;;
    4)
        echo "Log của service:"
        journalctl -u $SERVICE_NAME -f
        ;;
    5)
        echo "Thoát."
        exit 0
        ;;
    *)
        echo "Lựa chọn không hợp lệ."
        ;;
esac

echo ""
echo "Để quản lý service, bạn có thể sử dụng các lệnh sau:"
echo "sudo systemctl start $SERVICE_NAME    # Khởi động service"
echo "sudo systemctl stop $SERVICE_NAME     # Dừng service"
echo "sudo systemctl restart $SERVICE_NAME  # Khởi động lại service"
echo "sudo systemctl status $SERVICE_NAME   # Kiểm tra trạng thái"
echo "sudo journalctl -u $SERVICE_NAME -f   # Xem log real-time"
