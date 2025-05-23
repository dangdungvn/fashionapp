<!-- filepath: d:\Workspace\flutter\fullstack-fashionapp\README.md -->

<p align="center">
  <img src="fashionapp/assets/images/readme_home_screen_1.jpg" width="180" alt="Fashion App"/>
</p>

<h1 align="center">👗 Fashion App - Fullstack Fashion Application</h1>

<p align="center">
  <a href="https://flutter.dev" target="_blank"><img src="https://img.shields.io/badge/Flutter-%2302569B.svg?style=flat&logo=Flutter&logoColor=white" alt="Flutter"></a>
  <a href="https://dart.dev" target="_blank"><img src="https://img.shields.io/badge/Dart-%230175C2.svg?style=flat&logo=dart&logoColor=white" alt="Dart"></a>
  <a href="https://www.python.org" target="_blank"><img src="https://img.shields.io/badge/Python-3670A0?style=flat&logo=python&logoColor=ffdd54" alt="Python"></a>
  <a href="#license"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License"></a>
</p>

<p align="center"><b>Cross-platform, modern, secure fashion shopping application with integrated payment.</b></p>

---

## 📋 Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Technologies](#technologies)
- [Quick Setup](#quick-setup)
- [Project Structure](#project-structure)
- [Environment](#environment)
- [API](#api)
- [Demo Screenshots](#demo-screenshots)
- [Contributing](#contributing)
- [Author & Contact](#author--contact)
- [License](#license)

---

## 👋 Introduction

Fashion App is a fullstack project comprising a Flutter application (mobile/web) and Python Django backend, allowing users to browse, shop, and pay for fashion products conveniently and securely.

---

## ✨ Features

<table>
  <tr>
    <td>🛍️ Browse & shop products</td>
    <td>👤 Account management</td>
    <td>🛒 Shopping cart & checkout</td>
  </tr>
  <tr>
    <td>💳 Payment integration</td>
    <td>🔒 Security, authentication</td>
    <td>📱 Beautiful, responsive UI</td>
  </tr>
</table>

---

## 🛠️ Technologies

| Frontend (Flutter) | Backend (Python/Django) | Payment |
|--------------------|------------------------|------------|
| Flutter SDK        | Django REST API        | Stripe, etc.|
| Dart               | SQLite                 | Secure Payment |
| Provider           | Auth & Security        | Order Management |
| Cross-platform     |                        |              |

---

## ⚡ Quick Setup

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
# Activate virtual environment:
# Linux/Mac: source venv/bin/activate
# Windows:   venv\Scripts\activate
pip install -r requirements.txt
cd fashion_backend
python manage.py runserver
```

</details>

---

## 📂 Project Structure

```text
fullstack-fashionapp/
├── fashionapp/           # Flutter application
│   ├── lib/             # Dart source code
│   ├── assets/          # Images, fonts, ...
│   └── pubspec.yaml     # Flutter dependencies
│
├── pybackend/           # Python Backend
│   ├── fashion_backend/ # Backend source
│   └── requirements.txt # Python dependencies
│
└── fashion_payment/     # Payment module
```

---

## ⚙️ Environment

- `.env.development`: Development configuration
- `.env.production`: Production configuration

---

## 🔌 API

<details>
<summary><b>Product Management</b></summary>

- `GET /api/products/` — Product list
- `GET /api/products/{id}/` — Product details
- `GET /api/products/byType/` — By type
- `GET /api/products/categories/` — Categories
- `GET /api/products/popular/` — Popular items
- `GET /api/products/search/` — Search

</details>
<details>
<summary><b>Shopping Cart</b></summary>

- `GET /api/cart/me/` — Current cart
- `POST /api/cart/add/` — Add product
- `DELETE /api/cart/delete/` — Remove product
- `PATCH /api/cart/update/` — Update quantity
- `GET /api/cart/count/` — Count products

</details>
<details>
<summary><b>Orders</b></summary>

- `POST /api/orders/add` — Create order
- `GET /api/orders/me/` — Order history
- `GET /api/orders/single/` — Order details
- `GET /api/orders/statistics/` — Statistics

</details>
<details>
<summary><b>User Authentication</b></summary>

- `POST /auth/token/login/` — Login
- `POST /auth/token/logout/` — Logout
- `POST /auth/users/` — Register
- `GET /auth/users/me/` — User profile
- `PATCH /auth/users/me/` — Update profile

</details>
<details>
<summary><b>Address</b></summary>

- `GET /api/address/addresslist/` — Address list
- `POST /api/address/add/` — Add address
- `PATCH /api/address/default/` — Set default
- `DELETE /api/address/delete/` — Delete address

</details>

> 📄 <b>View full API documentation:</b> [http://localhost:8000/api/schema/](http://localhost:8000/api/schema/) or `schema.json` file.

---

## 🖼️ Demo Screenshots

<details>
<summary><b>🏠 Home Screen & Search</b></summary>
<p align="center">
  <img src="fashionapp/assets/images/readme_home_screen_1.jpg" width="220"/>
  <img src="fashionapp/assets/images/readme_home_screen_2.jpg" width="220"/>
  <img src="fashionapp/assets/images/readme_search_screen.jpg" width="220"/>
</p>
</details>
<details>
<summary><b>🛒 Cart & Checkout</b></summary>
<p align="center">
  <img src="fashionapp/assets/images/readme_cart_screen.jpg" width="220"/>
  <img src="fashionapp/assets/images/readme_checkout_screen.jpg" width="220"/>
  <img src="fashionapp/assets/images/readme_profile_screen.jpg" width="220"/>
</p>
</details>
<details>
<summary><b>📋 Categories, Notifications & Orders</b></summary>
<p align="center">
  <img src="fashionapp/assets/images/readme_item_category_screen.jpg" width="220"/>
  <img src="fashionapp/assets/images/readme_notification_screen.jpg" width="220"/>
  <img src="fashionapp/assets/images/readme_order_screen.jpg" width="220"/>
</p>
</details>
<details>
<summary><b>📍 Address</b></summary>
<p align="center">
  <img src="fashionapp/assets/images/readme_address_screen.jpg" width="220"/>
  <img src="fashionapp/assets/images/readme_add_address_screen.jpg" width="220"/>
</p>
</details>

---

## 🤝 Contributing

All contributions are welcome! Please create a pull request or issue if you find a bug or want to improve the project.

---

## 👨‍💻 Author & Contact

- **Phan Van Tung**  
  Email: <tungmj1605@gmail.com>  
  GitHub: [dangdungvn](https://github.com/dangdungvn)

---

## 📄 License

MIT License © 2024 Phan Van Tung
