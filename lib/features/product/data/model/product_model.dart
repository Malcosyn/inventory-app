import 'package:inventory_app/features/product/domain/entity/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.warungId,
    required super.categoryId,
    required super.supplierId,
    required super.imageUrl,
    required super.name,
    required super.barcode,
    required super.createdAt,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String,
      warungId: map['warung_id'] as int,
      categoryId: map['category_id'] as int,
      supplierId: map['supplier_id'] as String,
      imageUrl: map['image_url'] as String? ?? '',
      name: map['name'] as String,
      barcode: map['barcode'] as String? ?? '',
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }
}
