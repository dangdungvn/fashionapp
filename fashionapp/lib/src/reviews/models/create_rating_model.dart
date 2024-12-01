import 'dart:convert';

CreateRating createRatingFromJson(String str) =>
    CreateRating.fromJson(json.decode(str));

String createRatingToJson(CreateRating data) => json.encode(data.toJson());

class CreateRating {
  final String review;
  final double rating;
  final int product;
  final int order;

  CreateRating({
    required this.review,
    required this.rating,
    required this.product,
    required this.order,
  });

  factory CreateRating.fromJson(Map<String, dynamic> json) => CreateRating(
        review: json["review"],
        rating: json["rating"]?.toDouble(),
        product: json["product"],
        order: json["order"],
      );

  Map<String, dynamic> toJson() => {
        "review": review,
        "rating": rating,
        "product": product,
        "order": order,
      };
}
