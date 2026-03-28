import 'dart:convert';

List<Store> storeFromJson(String str) => List<Store>.from(json.decode(str).map((x) => Store.fromJson(x)));

String storeToJson(List<Store> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Store {
  int id;
  String ownerId;
  String name;
  String phone;
  String address;
  bool isOpen24H;
  DateTime createdAt;

  Store({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.phone,
    required this.address,
    required this.isOpen24H,
    required this.createdAt,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
    id: json["id"],
    ownerId: json["owner_id"],
    name: json["name"],
    phone: json["phone"],
    address: json["address"],
    isOpen24H: json["is_open_24h"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "owner_id": ownerId,
    "name": name,
    "phone": phone,
    "address": address,
    "is_open_24h": isOpen24H,
    "created_at": createdAt.toIso8601String(),
  };
}
