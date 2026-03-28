import 'package:inventory_app/features/store/domain/entity/store.dart';

class StoreModel extends Store {
  StoreModel({
    required super.id,
    required super.ownerId,
    required super.name,
    required super.phone,
    required super.address,
    required super.isOpen24H,
    required super.createdAt,
  });
}
