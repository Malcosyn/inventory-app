import 'package:fpdart/fpdart.dart';
import 'package:inventory_app/core/error/failures.dart';
import 'package:inventory_app/features/store/domain/entity/store.dart';

abstract interface class StoreRepository {
  Future<Either<Failures, List<Store>>> getStoresByOwner(String ownerId);
}
