import 'package:fpdart/fpdart.dart';
import 'package:inventory_app/core/error/failures.dart';
import 'package:inventory_app/core/usecases/usecase.dart';
import 'package:inventory_app/features/product/domain/entity/product.dart';
import 'package:inventory_app/features/product/domain/repository/product_repository.dart';

class GetProductsUsecase implements Usecase<List<Product>, GetProductsParams> {
  final ProductRepository productRepository;

  GetProductsUsecase({required this.productRepository});

  @override
  Future<Either<Failures, List<Product>>> call(GetProductsParams param) {
    return productRepository.getByStoreId(param.storeId);
  }
}

class GetProductsParams {
  final int storeId;

  GetProductsParams({required this.storeId});
}
