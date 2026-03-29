import 'package:fpdart/fpdart.dart';
import 'package:inventory_app/core/error/failures.dart';
import 'package:inventory_app/features/category/domain/entity/category.dart';

abstract interface class CategoryRepository {
  Future<Either<Failures, List<Category>>> getByStoreId(int storeId);
}
