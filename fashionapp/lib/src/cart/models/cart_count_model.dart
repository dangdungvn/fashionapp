import 'dart:convert';

CartCountModel cartCountModelFromJson(String str) =>
    CartCountModel.fromJson(json.decode(str));

String cartCountModelToJson(CartCountModel data) => json.encode(data.toJson());

class CartCountModel {
  final int cartCount;

  CartCountModel({
    required this.cartCount,
  });

  factory CartCountModel.fromJson(Map<String, dynamic> json) => CartCountModel(
        cartCount: json["cart_count"],
      );

  Map<String, dynamic> toJson() => {
        "cart_count": cartCount,
      };
}
