import 'package:inventory_app/features/stock_movement/domain/entity/stock_movement.dart';

class StockMovementModel extends StockMovement {
  StockMovementModel({
    required super.id,
    required super.productId,
    required super.type,
    required super.quantity,
    required super.stockAfter,
    required super.note,
    required super.createdAt,
  });

  factory StockMovementModel.fromMap(Map<String, dynamic> map) {
    return StockMovementModel(
      id: map['id'] as String,
      productId: map['product_id'] as String,
      type: map['type'] as String,
      quantity: (map['quantity'] as num).toInt(),
      stockAfter: (map['stock_after'] as num).toInt(),
      note: map['note'] as String? ?? '',
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }
}
