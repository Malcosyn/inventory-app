import 'package:fpdart/fpdart.dart';
import 'package:inventory_app/core/error/failures.dart';
import 'package:inventory_app/core/usecases/usecase.dart';
import 'package:inventory_app/features/category/domain/entity/category.dart';
import 'package:inventory_app/features/category/domain/repository/category_repository.dart';

class GetCategoriesUsecase
    implements Usecase<List<Category>, GetCategoriesParams> {
  final CategoryRepository categoryRepository;

  GetCategoriesUsecase({required this.categoryRepository});

  @override
  Future<Either<Failures, List<Category>>> call(GetCategoriesParams param) {
    return categoryRepository.getByStoreId(param.storeId);
  }
}

class GetCategoriesParams {
  final int storeId;

  GetCategoriesParams({required this.storeId});
}
