import 'dart:convert';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  final int id;
  final String customerId;
  final List<OrderProduct> orderProducts;
  final List<int> rated;
  final int totalQuantity;
  final double subtotal;
  final double total;
  final String deliveryStatus;
  final String paymentStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int user;
  final int address;

  Order({
    required this.id,
    required this.customerId,
    required this.orderProducts,
    required this.rated,
    required this.totalQuantity,
    required this.subtotal,
    required this.total,
    required this.deliveryStatus,
    required this.paymentStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.address,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        customerId: json["customer_id"],
        orderProducts: List<OrderProduct>.from(
            json["order_products"].map((x) => OrderProduct.fromJson(x))),
        rated: List<int>.from(json["rated"].map((x) => x)),
        totalQuantity: json["total_quantity"],
        subtotal: json["subtotal"],
        total: json["total"],
        deliveryStatus: json["delivery_status"],
        paymentStatus: json["payment_status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: json["user"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "order_products":
            List<dynamic>.from(orderProducts.map((x) => x.toJson())),
        "rated": List<dynamic>.from(rated.map((x) => x)),
        "total_quantity": totalQuantity,
        "subtotal": subtotal,
        "total": total,
        "delivery_status": deliveryStatus,
        "payment_status": paymentStatus,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user,
        "address": address,
      };
}

class OrderProduct {
  final int productId;
  final String imageUrl;
  final String title;
  final double price;
  final int quantity;
  final String size;
  final String color;

  OrderProduct({
    required this.productId,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.quantity,
    required this.size,
    required this.color,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) => OrderProduct(
        productId: json["product_id"],
        imageUrl: json["imageUrl"],
        title: json["title"],
        price: json["price"]?.toDouble(),
        quantity: json["quantity"],
        size: json["size"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "imageUrl": imageUrl,
        "title": title,
        "price": price,
        "quantity": quantity,
        "size": size,
        "color": color,
      };
}
