# Hướng dẫn thiết lập GitHub Actions để tự động triển khai lên Azure VM

## Giới thiệu

Tài liệu này hướng dẫn cách thiết lập GitHub Actions để tự động triển khai các backend của Fashion App lên Azure VM khi có code mới được push lên GitHub.

## Các bước thiết lập

### 1. Thiết lập SSH Key

1. Tạo SSH key trên máy local của bạn (nếu chưa có):
   ```bash
   ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
   ```
   
2. Copy public key vào Azure VM:
   ```bash
   ssh-copy-id username@your-azure-vm-ip
   ```

3. Kiểm tra kết nối:
   ```bash
   ssh username@your-azure-vm-ip
   ```

### 2. Thiết lập GitHub Secrets

Trong repository GitHub của bạn, thêm các secrets sau:

1. Đi đến repository > Settings > Secrets and variables > Actions
2. Thêm các secrets sau:
   - `AZURE_VM_HOST`: Địa chỉ IP của Azure VM
   - `AZURE_VM_USERNAME`: Username đăng nhập SSH
   - `AZURE_VM_SSH_KEY`: Private SSH key của bạn (toàn bộ nội dung file `id_rsa`)
   - `AZURE_VM_PORT`: Cổng SSH (thường là 22)
   - `PROJECT_PATH`: Đường dẫn đến thư mục project trên Azure VM

### 3. Thiết lập Git trên Azure VM

1. Login vào Azure VM:
   ```bash
   ssh username@your-azure-vm-ip
   ```

2. Clone repository hoặc set up remote:
   ```bash
   # Nếu chưa có repository local:
   git clone https://github.com/your-username/your-repo.git

   # Nếu đã có code:
   cd /path/to/your/project
   git init
   git remote add origin https://github.com/your-username/your-repo.git
   ```

3. Thiết lập credentials để không cần nhập password:
   ```bash
   git config --global credential.helper store
   ```

### 4. Kiểm tra Workflow

1. Push thay đổi lên branch main để kích hoạt workflow
2. Hoặc kích hoạt thủ công từ tab Actions trong repository GitHub

## Workflow Deployment

Workflow đã được thiết lập để:
1. Chạy khi có push lên branch main hoặc khi được kích hoạt thủ công
2. Kết nối đến Azure VM qua SSH
3. Pull code mới từ GitHub
4. Cài đặt dependencies nếu cần
5. Khởi động lại các backend

## Kiểm tra trạng thái

Sau khi deployment hoàn tất, bạn có thể kiểm tra trạng thái các backend:

```bash
# Kiểm tra Python backend
ssh username@your-azure-vm-ip "cd /path/to/project/pybackend && python run_azure_server.py --action status"

# Kiểm tra Node.js backend
ssh username@your-azure-vm-ip "cd /path/to/project/fashion_payment && node run_azure_server.js status"
```
