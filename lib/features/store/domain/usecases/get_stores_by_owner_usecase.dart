import 'package:fpdart/fpdart.dart';
import 'package:inventory_app/core/error/failures.dart';
import 'package:inventory_app/core/usecases/usecase.dart';
import 'package:inventory_app/features/store/domain/entity/store.dart';
import 'package:inventory_app/features/store/domain/repository/store_repository.dart';

class GetStoresByOwnerUsecase
    implements Usecase<List<Store>, GetStoresByOwnerParams> {
  final StoreRepository storeRepository;

  GetStoresByOwnerUsecase({required this.storeRepository});

  @override
  Future<Either<Failures, List<Store>>> call(GetStoresByOwnerParams param) {
    return storeRepository.getStoresByOwner(param.ownerId);
  }
}

class GetStoresByOwnerParams {
  final String ownerId;

  GetStoresByOwnerParams({required this.ownerId});
}
