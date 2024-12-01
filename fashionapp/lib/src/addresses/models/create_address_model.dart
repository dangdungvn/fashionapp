import 'dart:convert';

CreateAddress createAddressFromJson(String str) =>
    CreateAddress.fromJson(json.decode(str));

String createAddressToJson(CreateAddress data) => json.encode(data.toJson());

class CreateAddress {
  final double lat;
  final double lng;
  final bool isDefault;
  final String address;
  final String phone;
  final String addressType;

  CreateAddress({
    required this.lat,
    required this.lng,
    required this.isDefault,
    required this.address,
    required this.phone,
    required this.addressType,
  });

  factory CreateAddress.fromJson(Map<String, dynamic> json) => CreateAddress(
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
        isDefault: json["isDefault"],
        address: json["address"],
        phone: json["phone"],
        addressType: json["addressType"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
        "isDefault": isDefault,
        "address": address,
        "phone": phone,
        "addressType": addressType,
      };
}
