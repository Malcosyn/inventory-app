import 'package:fpdart/fpdart.dart';
import 'package:inventory_app/core/error/failures.dart';
import 'package:inventory_app/features/product/domain/entity/product.dart';

abstract interface class ProductRepository {
  Future<Either<Failures, List<Product>>> getByStoreId(int storeId);
}
