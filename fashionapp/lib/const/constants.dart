import 'package:fashionapp/src/categories/models/categories_model.dart';
import 'package:fashionapp/src/products/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/const/resource.dart';

// Gradient chính - nhẹ nhàng, hiện đại
LinearGradient kGradient = const LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Kolors.kPrimaryLight,
    Kolors.kSecondaryLight,
    Kolors.kPrimary,
  ],
);

// Gradient chính đậm hơn
LinearGradient kPGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Kolors.kPrimary,
    Kolors.kPrimary.withOpacity(0.8),
    Kolors.kAccent,
  ],
);

// Gradient cho buttons
LinearGradient kBtnGradient = const LinearGradient(
  begin: Alignment.bottomLeft,
  end: Alignment.bottomRight,
  colors: [
    Kolors.kPrimary,
    Kolors.kAccent,
  ],
);

// Bo tròn các góc - giữ nguyên
BorderRadiusGeometry kClippingRadius = const BorderRadius.only(
  topLeft: Radius.circular(20),
  topRight: Radius.circular(20),
);

BorderRadiusGeometry kRadiusAll = BorderRadius.circular(16);

BorderRadiusGeometry kRadiusTop = const BorderRadius.only(
  topLeft: Radius.circular(16),
  topRight: Radius.circular(16),
);

BorderRadiusGeometry kRadiusBottom = const BorderRadius.only(
  bottomLeft: Radius.circular(16),
  bottomRight: Radius.circular(16),
);

// Giữ nguyên các placeholder và error widgets
Widget Function(BuildContext, String)? placeholder = (p0, p1) => Image.asset(
      R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
      fit: BoxFit.cover,
    );

Widget Function(BuildContext, String, Object)? errorWidget =
    (p0, p1, p3) => Image.asset(
          R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
          fit: BoxFit.cover,
        );

// Giữ nguyên các dữ liệu có sẵn
List<String> images = [
  "https://img.freepik.com/free-vector/mega-sale-banner-your-online-store-realistic-style-with-phone-map-cart-bag-gift-vector-illustration_548887-132.jpg?t=st=1733752337~exp=1733755937~hmac=c04bc02fef76ccbccc5c8d6f0231590c970718557359a9f49e23ea1680003717&w=2000",
  "https://img.freepik.com/free-vector/large-sale-word-with-shopping-cart-gift-boxes-store-map-with-pointer-realistic-style-vector-illustration_548887-126.jpg?t=st=1733752536~exp=1733756136~hmac=321e7ff85af210931a26b2b0c5f3c1210bda43f828a6ec5e6c69b66ca8ca0438&w=2000",
  "https://img.freepik.com/free-vector/mega-sale-promotion-banner-with-3d-cart-with-gift-platform-shopping-bags-balloons-vector-illustration_548887-172.jpg?t=st=1733752838~exp=1733756438~hmac=16efbd00292bcad8a86565ee1f892f877ccb67dcba3246047dbce10ea6402ad3&w=2000",
  "https://img.freepik.com/free-vector/e-commerce-colorful-concept_1284-48408.jpg?t=st=1733752869~exp=1733756469~hmac=a06432967f23561a52d8a0ed3200d2e6497876fc4c126985ebc8e2baf915acea&w=1800",
  "https://img.freepik.com/free-vector/banner-holiday-sale-with-store-gift-bag-gifts-location-realistic-style-vector-illustration_548887-118.jpg?t=st=1733752916~exp=1733756516~hmac=a0cbfeb7fda63e43f803cb360d6427215ebdd05fe50c98a6fa0dabff1ef526de&w=2000",
  "https://img.freepik.com/free-vector/banner-concept-fast-online-order-with-store-phone-gifts-gift-bags-location-realistic-style-vector-illustration_548887-124.jpg?t=st=1733752966~exp=1733756566~hmac=dbbb7b696bd360aa11565d81549197743031b5e991a3dba8ab4de74e1e67bbef&w=1800",
];

// Giữ nguyên các dữ liệu categories
List<Categories> categories = [
  Categories(
      title: "Pants",
      id: 1,
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/authenification-b4dc9.appspot.com/o/uploads%2Fjeans.svg?alt=media&token=eb62f916-a4c2-441a-a469-5684f1a62526"),
  Categories(
      title: "T-Shirts",
      id: 5,
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/authenification-b4dc9.appspot.com/o/uploads%2Fjersey.svg?alt=media&token=6ca7eabd-54b3-47bb-bb8f-41c3a8920171"),
  Categories(
      title: "Sneakers",
      id: 3,
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/authenification-b4dc9.appspot.com/o/uploads%2Frunning_shoe.svg?alt=media&token=0dcb0e57-315e-457c-89dc-1233f6421368"),
  Categories(
      title: "Dresses",
      id: 2,
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/authenification-b4dc9.appspot.com/o/uploads%2Fdress.svg?alt=media&token=cf832383-4c8a-4ee1-9676-b66c4d515a1c"),
  Categories(
      title: "Jackets",
      id: 4,
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/authenification-b4dc9.appspot.com/o/uploads%2Fjacket.svg?alt=media&token=ffdc9a1e-917f-4e8f-b58e-4df2e6e8587e")
];

// Giữ nguyên các dữ liệu products
List<Products> products = [
  Products(
      id: 3,
      title: "Converse Chuck Taylor All Star",
      price: 60.0,
      description:
          "The classic Chuck Taylor All Star sneaker from Converse, featuring a timeless design and comfortable fit.",
      isFeatured: true,
      clothesType: "kids",
      ratings: 4.333333333333333,
      colors: ["black", "white", "red"],
      imageUrls: [
        "https://media.cnn.com/api/v1/images/stellar/prod/220210051008-04-lv-virgil-abloh.jpg?q=w_2000,c_fill/f_webp",
        "https://media.cnn.com/api/v1/images/stellar/prod/220210051008-04-lv-virgil-abloh.jpg?q=w_2000,c_fill/f_webp"
      ],
      sizes: ["7", "8", "9", "10", "11"],
      createdAt: DateTime.parse("2024-06-06T07:57:45Z"),
      category: 3,
      brand: 1),
  Products(
      id: 1,
      title: "LV Trainers",
      price: 798.88,
      description:
          "LV Trainers blend sleek style with athletic functionality, featuring bold logos, premium materials, and comfortable designs that elevate your everyday look with a touch of luxury.",
      isFeatured: true,
      clothesType: "women",
      ratings: 4.5,
      colors: ["white", "black", "red"],
      imageUrls: [
        "https://media.cnn.com/api/v1/images/stellar/prod/220210051008-04-lv-virgil-abloh.jpg?q=w_2000,c_fill/f_webp",
        "https://media.cnn.com/api/v1/images/stellar/prod/220210051008-04-lv-virgil-abloh.jpg?q=w_2000,c_fill/f_webp"
      ],
      sizes: ["7", "8", "9", "10", "11"],
      createdAt: DateTime.parse("2024-06-06T07:49:15Z"),
      category: 3,
      brand: 1),
  Products(
      id: 2,
      title: "Adidas Ultraboost",
      price: 180.0,
      description:
          "Experience the comfort and energy return of the Ultraboost, designed for running and everyday wear.",
      isFeatured: true,
      clothesType: "unisex",
      ratings: 5.0,
      colors: ["navy", "grey", "blue"],
      imageUrls: [
        "https://media.cnn.com/api/v1/images/stellar/prod/220210051008-04-lv-virgil-abloh.jpg?q=w_2000,c_fill/f_webp",
        "https://media.cnn.com/api/v1/images/stellar/prod/220210051008-04-lv-virgil-abloh.jpg?q=w_2000,c_fill/f_webp"
      ],
      sizes: ["7", "8", "9", "10", "11"],
      createdAt: DateTime.parse("2024-06-06T07:55:20Z"),
      category: 3,
      brand: 1)
];

String avatar =
    'https://firebasestorage.googleapis.com/v0/b/authenification-b4dc9.appspot.com/o/uploads%2Favatar.png?alt=media&token=7da81de9-a163-4296-86ac-3194c490ce15';
