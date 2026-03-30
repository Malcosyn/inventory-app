class Order {
  final String id;
  final String productId;
  final int totalPrice;
  final int totalItem;
  final String unitType;

  Order({
    required this.id,
    required this.productId,
    required this.totalPrice,
    required this.totalItem,
    required this.unitType,
  });
}
