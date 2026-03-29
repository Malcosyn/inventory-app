import 'package:inventory_app/features/inventory/domain/entity/inventory.dart';

class InventoryModel extends Inventory {
  InventoryModel({
    required super.id,
    required super.productId,
    required super.costPrice,
    required super.sellingPrice,
    required super.stockQuantity,
    required super.lowStockThreshold,
    required super.updatedAt,
  });

  factory InventoryModel.fromMap(Map<String, dynamic> map) {
    return InventoryModel(
      id: map['id'] as String,
      productId: map['product_id'] as String,
      costPrice: (map['cost_price'] as num).toDouble(),
      sellingPrice: (map['selling_price'] as num).toDouble(),
      stockQuantity: (map['stock_quantity'] as num).toInt(),
      lowStockThreshold: (map['low_stock_threshold'] as num).toInt(),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }
}
