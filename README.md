# Fashion App - Ứng dụng Thời trang Fullstack

Dự án ứng dụng thời trang được phát triển bởi **Phan Văn Tùng**, sử dụng Flutter và Python để xây dựng một nền tảng mua sắm thời trang trực tuyến hoàn chỉnh.

## Giới thiệu về tác giả
- **Họ và tên**: Phan Văn Tùng
- **Email**: phantung.work@gmail.com
- **GitHub**: [phantung.dev](https://github.com/phantung.dev)

## Tính năng chính

- 🛍️ Duyệt và mua sắm sản phẩm thời trang
- 👤 Quản lý tài khoản người dùng
- 🛒 Giỏ hàng và thanh toán
- 💳 Tích hợp cổng thanh toán
- 📱 Giao diện người dùng đẹp và phản hồi nhanh
- 🔒 Bảo mật và xác thực người dùng

## Công nghệ sử dụng

### Frontend (Mobile & Web)
- Flutter SDK
- Dart
- Các package quản lý state và routing
- Hỗ trợ đa nền tảng (iOS, Android, Web)

### Backend
- Python
- FastAPI/Django framework
- RESTful API
- Cơ sở dữ liệu quan hệ
- Xác thực và bảo mật

### Thanh toán
- Tích hợp cổng thanh toán
- Xử lý giao dịch an toàn
- Quản lý đơn hàng

## Cài đặt và Chạy

### Yêu cầu
- Flutter SDK
- Python 3.8+
- Pip package manager
- Virtual environment

### Frontend (Flutter)
1. Di chuyển vào thư mục fashionapp:
```bash
cd fashionapp
```

2. Cài đặt dependencies:
```bash
flutter pub get
```

3. Chạy ứng dụng:
```bash
flutter run
```

### Backend (Python)
1. Di chuyển vào thư mục backend:
```bash
cd pybackend
```

2. Tạo và kích hoạt môi trường ảo:
```bash
python -m venv venv
source venv/bin/activate  # Linux/Mac
venv\Scripts\activate     # Windows
```

3. Cài đặt dependencies:
```bash
pip install -r requirements.txt
```

4. Chạy server:
```bash
cd fashion_backend
python manage.py runserver
```

## Cấu trúc dự án

```
fullstack-fashionapp/
├── fashionapp/           # Flutter application
│   ├── lib/             # Dart source code
│   ├── assets/          # Images, fonts, etc.
│   └── pubspec.yaml     # Flutter dependencies
│
├── pybackend/           # Python backend
│   ├── fashion_backend/ # Backend source code
│   └── requirements.txt # Python dependencies
│
└── fashion_payment/     # Payment integration module
```

## Môi trường

Dự án sử dụng các file môi trường khác nhau cho development và production:
- `.env.development`: Cấu hình cho môi trường phát triển
- `.env.production`: Cấu hình cho môi trường production

## Đóng góp

Mọi đóng góp cho dự án đều được hoan nghênh. Vui lòng tạo pull request hoặc báo cáo issues nếu bạn phát hiện bất kỳ vấn đề nào.

## Liên hệ

Nếu bạn có bất kỳ câu hỏi hoặc góp ý nào, vui lòng liên hệ:
- Email: phantung.work@gmail.com
- GitHub: [phantung.dev](https://github.com/phantung.dev)

## Giấy phép

Copyright © 2024 Phan Văn Tùng. All rights reserved. 