class Product {
  final String id;
  final int warungId;
  final int categoryId;
  final String supplierId;
  final String imageUrl;
  final String name;
  final String barcode;
  final DateTime createdAt;

  Product({
    required this.id,
    required this.warungId,
    required this.categoryId,
    required this.supplierId,
    required this.imageUrl,
    required this.name,
    required this.barcode,
    required this.createdAt,
  });
}
