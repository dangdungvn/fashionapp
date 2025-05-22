<!-- filepath: d:\Workspace\flutter\fullstack-fashionapp\README.md -->

<p align="center">
  <img src="fashionapp/assets/images/readme_home_screen_1.jpg" width="180" alt="Fashion App"/>
</p>

<h1 align="center">👗 Fashion App - Ứng dụng Thời trang Fullstack</h1>

<p align="center">
  <a href="https://flutter.dev" target="_blank"><img src="https://img.shields.io/badge/Flutter-%2302569B.svg?style=flat&logo=Flutter&logoColor=white" alt="Flutter"></a>
  <a href="https://dart.dev" target="_blank"><img src="https://img.shields.io/badge/Dart-%230175C2.svg?style=flat&logo=dart&logoColor=white" alt="Dart"></a>
  <a href="https://www.python.org" target="_blank"><img src="https://img.shields.io/badge/Python-3670A0?style=flat&logo=python&logoColor=ffdd54" alt="Python"></a>
  <a href="#giay-phep"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License"></a>
</p>

<p align="center"><b>Ứng dụng mua sắm thời trang đa nền tảng, hiện đại, bảo mật, tích hợp thanh toán.</b></p>

---

## 📋 Mục lục

- [Giới thiệu](#giới-thiệu)
- [Tính năng](#tính-năng)
- [Công nghệ](#công-nghệ)
- [Cài đặt nhanh](#cài-đặt-nhanh)
- [Cấu trúc dự án](#cấu-trúc-dự-án)
- [Môi trường](#môi-trường)
- [API](#api)
- [Ảnh demo](#ảnh-demo)
- [Đóng góp](#đóng-góp)
- [Tác giả & Liên hệ](#tác-giả--liên-hệ)
- [Giấy phép](#giấy-phép)

---

## 👋 Giới thiệu

Fashion App là dự án fullstack gồm ứng dụng Flutter (mobile/web) và backend Python Django, giúp người dùng duyệt, mua sắm, thanh toán sản phẩm thời trang một cách tiện lợi, an toàn.

---

## ✨ Tính năng

<table>
  <tr>
    <td>🛍️ Duyệt & mua sắm sản phẩm</td>
    <td>👤 Quản lý tài khoản</td>
    <td>🛒 Giỏ hàng & thanh toán</td>
  </tr>
  <tr>
    <td>💳 Tích hợp thanh toán</td>
    <td>🔒 Bảo mật, xác thực</td>
    <td>📱 Giao diện đẹp, responsive</td>
  </tr>
</table>

---

## 🛠️ Công nghệ

| Frontend (Flutter) | Backend (Python/Django) | Thanh toán |
|--------------------|------------------------|------------|
| Flutter SDK        | Django REST API        | Stripe, v.v.|
| Dart               | SQLite                 | Secure Payment |
| Provider           | Auth & Security        | Order Management |
| Cross-platform     |                        |              |

---

## ⚡ Cài đặt nhanh

<details>
<summary><b>Frontend (Flutter)</b></summary>

```bash
cd fashionapp
flutter pub get
flutter run
```

</details>

<details>
<summary><b>Backend (Python/Django)</b></summary>

```bash
cd pybackend
python -m venv venv
# Kích hoạt môi trường ảo:
# Linux/Mac: source venv/bin/activate
# Windows:   venv\Scripts\activate
pip install -r requirements.txt
cd fashion_backend
python manage.py runserver
```

</details>

---

## 📂 Cấu trúc dự án

```text
fullstack-fashionapp/
├── fashionapp/           # Ứng dụng Flutter
│   ├── lib/             # Mã nguồn Dart
│   ├── assets/          # Ảnh, font, ...
│   └── pubspec.yaml     # Dependencies Flutter
│
├── pybackend/           # Backend Python
│   ├── fashion_backend/ # Source backend
│   └── requirements.txt # Dependencies Python
│
└── fashion_payment/     # Module thanh toán
```

---

## ⚙️ Môi trường

- `.env.development`: Cấu hình phát triển
- `.env.production`: Cấu hình production

---

## 🔌 API

<details>
<summary><b>Quản lý sản phẩm</b></summary>

- `GET /api/products/` — Danh sách sản phẩm
- `GET /api/products/{id}/` — Chi tiết sản phẩm
- `GET /api/products/byType/` — Theo loại
- `GET /api/products/categories/` — Danh mục
- `GET /api/products/popular/` — Phổ biến
- `GET /api/products/search/` — Tìm kiếm

</details>
<details>
<summary><b>Giỏ hàng</b></summary>

- `GET /api/cart/me/` — Giỏ hàng hiện tại
- `POST /api/cart/add/` — Thêm sản phẩm
- `DELETE /api/cart/delete/` — Xóa sản phẩm
- `PATCH /api/cart/update/` — Cập nhật số lượng
- `GET /api/cart/count/` — Đếm sản phẩm

</details>
<details>
<summary><b>Đơn hàng</b></summary>

- `POST /api/orders/add` — Tạo đơn hàng
- `GET /api/orders/me/` — Lịch sử đơn hàng
- `GET /api/orders/single/` — Chi tiết đơn hàng
- `GET /api/orders/statistics/` — Thống kê

</details>
<details>
<summary><b>Xác thực người dùng</b></summary>

- `POST /auth/token/login/` — Đăng nhập
- `POST /auth/token/logout/` — Đăng xuất
- `POST /auth/users/` — Đăng ký
- `GET /auth/users/me/` — Thông tin cá nhân
- `PATCH /auth/users/me/` — Cập nhật thông tin

</details>
<details>
<summary><b>Địa chỉ</b></summary>

- `GET /api/address/addresslist/` — Danh sách địa chỉ
- `POST /api/address/add/` — Thêm địa chỉ
- `PATCH /api/address/default/` — Đặt mặc định
- `DELETE /api/address/delete/` — Xóa địa chỉ

</details>

> 📄 <b>Xem tài liệu API đầy đủ:</b> [http://localhost:8000/api/schema/](http://localhost:8000/api/schema/) hoặc file `schema.json`.

---

## 🖼️ Ảnh demo

<details>
<summary><b>🏠 Màn hình chính & Tìm kiếm</b></summary>
<p align="center">
  <img src="fashionapp/assets/images/readme_home_screen_1.jpg" width="220"/>
  <img src="fashionapp/assets/images/readme_home_screen_2.jpg" width="220"/>
  <img src="fashionapp/assets/images/readme_search_screen.jpg" width="220"/>
</p>
</details>
<details>
<summary><b>🛒 Giỏ hàng & Thanh toán</b></summary>
<p align="center">
  <img src="fashionapp/assets/images/readme_cart_screen.jpg" width="220"/>
  <img src="fashionapp/assets/images/readme_checkout_screen.jpg" width="220"/>
  <img src="fashionapp/assets/images/readme_profile_screen.jpg" width="220"/>
</p>
</details>
<details>
<summary><b>📋 Danh mục & Thông báo & Đơn hàng</b></summary>
<p align="center">
  <img src="fashionapp/assets/images/readme_item_category_screen.jpg" width="220"/>
  <img src="fashionapp/assets/images/readme_notification_screen.jpg" width="220"/>
  <img src="fashionapp/assets/images/readme_order_screen.jpg" width="220"/>
</p>
</details>
<details>
<summary><b>📍 Địa chỉ</b></summary>
<p align="center">
  <img src="fashionapp/assets/images/readme_address_screen.jpg" width="220"/>
  <img src="fashionapp/assets/images/readme_add_address_screen.jpg" width="220"/>
</p>
</details>

---

## 🤝 Đóng góp

Mọi đóng góp đều được hoan nghênh! Hãy tạo pull request hoặc issue nếu bạn phát hiện lỗi hoặc muốn cải tiến dự án.

---

## 👨‍💻 Tác giả & Liên hệ

- **Phan Văn Tùng**  
  Email: <tungmj1605@gmail.com>  
  GitHub: [dangdungvn](https://github.com/dangdungvn)

---

## 📄 Giấy phép

MIT License © 2024 Phan Văn Tùng
