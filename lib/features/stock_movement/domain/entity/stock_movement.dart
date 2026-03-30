class StockMovement {
  final String id;
  final String productId;
  final String type;
  final int quantity;
  final int stockAfter;
  final String note;
  final DateTime createdAt;

  StockMovement({
    required this.id,
    required this.productId,
    required this.type,
    required this.quantity,
    required this.stockAfter,
    required this.note,
    required this.createdAt,
  });
}
