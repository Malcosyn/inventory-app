import 'package:fpdart/fpdart.dart';
import 'package:inventory_app/core/error/failures.dart';
import 'package:inventory_app/features/category/data/data_sources/category_supabase_data_source.dart';
import 'package:inventory_app/features/category/data/model/category_model.dart';
import 'package:inventory_app/features/category/domain/entity/category.dart';
import 'package:inventory_app/features/category/domain/repository/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategorySupabaseDataSource categorySupabaseDataSource;

  CategoryRepositoryImpl({required this.categorySupabaseDataSource});

  @override
  Future<Either<Failures, List<Category>>> getByStoreId(int storeId) async {
    try {
      final rows = await categorySupabaseDataSource.getByStoreId(storeId);
      return right(rows.map(CategoryModel.fromMap).toList());
    } catch (e) {
      return left(Failures(e.toString()));
    }
  }
}
