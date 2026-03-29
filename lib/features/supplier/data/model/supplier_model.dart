import 'package:inventory_app/features/supplier/domain/entity/supplier.dart';

class SupplierModel extends Supplier {
  SupplierModel({
    required super.id,
    required super.name,
    required super.phone,
    required super.address,
  });

  factory SupplierModel.fromMap(Map<String, dynamic> map) {
    return SupplierModel(
      id: map['id'] as String,
      name: map['name'] as String,
      phone: map['phone'] as String,
      address: map['address'] as String,
    );
  }
}
