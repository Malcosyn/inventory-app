import 'package:inventory_app/features/order/domain/entity/order.dart';

class OrderModel extends Order {
  OrderModel({
    required super.id,
    required super.productId,
    required super.totalPrice,
    required super.totalItem,
    required super.unitType,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] as String,
      productId: map['product_id'] as String,
      totalPrice: (map['total_price'] as num).toInt(),
      totalItem: (map['total_item'] as num).toInt(),
      unitType: map['unit_type'] as String,
    );
  }
}
