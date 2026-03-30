class Inventory {
  final String id;
  final String productId;
  final double costPrice;
  final double sellingPrice;
  final int stockQuantity;
  final int lowStockThreshold;
  final DateTime updatedAt;

  Inventory({
    required this.id,
    required this.productId,
    required this.costPrice,
    required this.sellingPrice,
    required this.stockQuantity,
    required this.lowStockThreshold,
    required this.updatedAt,
  });
}
