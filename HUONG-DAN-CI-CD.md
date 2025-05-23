# Hướng dẫn thiết lập GitHub Actions cho dự án Fashion App

## Giới thiệu

Tài liệu này hướng dẫn cách thiết lập GitHub Actions để tự động triển khai các backend của Fashion App (pybackend và fashion_payment) lên Azure VM khi có code mới được push lên GitHub.

## Các bước thiết lập

### 1. Thiết lập SSH Key

Bạn đã có SSH key từ Azure VM để kết nối đến server. Bây giờ chúng ta cần sử dụng key này để GitHub Actions có thể kết nối tới VM.

#### Chuẩn bị key cho GitHub Actions:

1. Mở file private key đã tải về từ Azure VM (thường có đuôi `.pem`)
2. Copy toàn bộ nội dung file này, bao gồm cả header (`-----BEGIN RSA PRIVATE KEY-----`) và footer (`-----END RSA PRIVATE KEY-----`)

### 2. Thiết lập GitHub Secrets

Trong repository GitHub của bạn, thêm các secrets sau:

1. Đi đến repository > Settings > Secrets and variables > Actions
2. Thêm các secrets sau:
   - `AZURE_VM_HOST`: Địa chỉ IP của Azure VM
   - `AZURE_VM_USERNAME`: Username đăng nhập SSH (thường là adminuser trên Azure VM)
   - `AZURE_VM_SSH_KEY`: Nội dung private SSH key đã copy ở bước 1
   - `AZURE_VM_PORT`: Cổng SSH (thường là 22)
   - `PROJECT_PATH`: Đường dẫn đến thư mục project trên Azure VM (ví dụ: `/home/adminuser/fullstack-fashionapp`)

### 3. Thiết lập Git trên Azure VM

1. Login vào Azure VM:
   ```bash
   ssh adminuser@your-azure-vm-ip
   ```

2. Nếu chưa clone repository, thực hiện các lệnh sau:
   ```bash
   # Tạo thư mục cho project nếu chưa có
   mkdir -p /path/to/project/folder
   cd /path/to/project/folder
   
   # Clone repository từ GitHub
   git clone https://github.com/your-username/fullstack-fashionapp.git
   ```

3. Thiết lập credentials để không cần nhập password khi pull code:
   ```bash
   cd fullstack-fashionapp
   git config --global credential.helper store
   git pull  # Nhập username/password để lưu vào credential store
   ```

### 4. Kiểm tra Workflow

Workflows đã được thiết lập để chạy khi có push vào nhánh `master`. Bạn có thể kích hoạt thủ công bằng cách:

1. Đi đến tab Actions trong repository GitHub
2. Chọn workflow "Deploy to Azure VM" 
3. Click nút "Run workflow"
4. Chọn nhánh `master` và click "Run workflow"

## Tài liệu tham khảo

- [Tài liệu GitHub Actions](https://docs.github.com/en/actions)
- [SSH Action](https://github.com/appleboy/ssh-action)

## Cách kiểm tra trạng thái các backend

Sau khi workflow hoàn tất, bạn có thể kiểm tra trạng thái các backend:

```bash
# Kiểm tra Python backend
ssh adminuser@your-azure-vm-ip "cd /path/to/project/pybackend && python run_azure_server.py --action status"

# Kiểm tra Node.js backend
ssh adminuser@your-azure-vm-ip "cd /path/to/project/fashion_payment && node run_azure_server.js status"
```
