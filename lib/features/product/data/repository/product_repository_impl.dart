import 'package:fpdart/fpdart.dart';
import 'package:inventory_app/core/error/failures.dart';
import 'package:inventory_app/features/product/data/data_sources/product_supabase_data_source.dart';
import 'package:inventory_app/features/product/data/model/product_model.dart';
import 'package:inventory_app/features/product/domain/entity/product.dart';
import 'package:inventory_app/features/product/domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductSupabaseDataSource productSupabaseDataSource;

  ProductRepositoryImpl({required this.productSupabaseDataSource});

  @override
  Future<Either<Failures, List<Product>>> getByStoreId(int storeId) async {
    try {
      final rows = await productSupabaseDataSource.getByStoreId(storeId);
      return right(rows.map(ProductModel.fromMap).toList());
    } catch (e) {
      return left(Failures(e.toString()));
    }
  }
}
