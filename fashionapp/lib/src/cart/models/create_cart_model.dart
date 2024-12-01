import 'dart:convert';

CreateCartModel createCartModelFromJson(String str) =>
    CreateCartModel.fromJson(json.decode(str));

String createCartModelToJson(CreateCartModel data) =>
    json.encode(data.toJson());

class CreateCartModel {
  final int product;
  final int quantity;
  final String size;
  final String color;

  CreateCartModel({
    required this.product,
    required this.quantity,
    required this.size,
    required this.color,
  });

  factory CreateCartModel.fromJson(Map<String, dynamic> json) =>
      CreateCartModel(
        product: json["product"],
        quantity: json["quantity"],
        size: json["size"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "product": product,
        "quantity": quantity,
        "size": size,
        "color": color,
      };
}
