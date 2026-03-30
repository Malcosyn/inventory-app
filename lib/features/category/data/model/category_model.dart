import 'package:inventory_app/features/category/domain/entity/category.dart';

class CategoryModel extends Category {
  CategoryModel({
    required super.id,
    required super.warungId,
    required super.name,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as int,
      warungId: map['warung_id'] as int,
      name: map['name'] as String,
    );
  }
}
