import 'package:fpdart/fpdart.dart';
import 'package:inventory_app/core/error/exception.dart';
import 'package:inventory_app/core/error/failures.dart';
import 'package:inventory_app/features/store/data/data_sources/store_supabase_data_source.dart';
import 'package:inventory_app/features/store/data/model/store_model.dart';
import 'package:inventory_app/features/store/domain/entity/store.dart';
import 'package:inventory_app/features/store/domain/repository/store_repository.dart';

class StoreRepositoryImpl implements StoreRepository {
  final StoreSupabaseDataSource storeSupabaseDataSource;

  StoreRepositoryImpl({required this.storeSupabaseDataSource});

  @override
  Future<Either<Failures, List<Store>>> getStoresByOwner(String ownerId) async {
    try {
      final rows = await storeSupabaseDataSource.getStoresByOwner(ownerId);
      final stores = rows
          .map(
            (row) => StoreModel(
              id: row['id'] as int,
              ownerId: row['owner_id'] as String,
              name: row['name'] as String,
              phone: row['phone'] as String,
              address: row['address'] as String,
              isOpen24H: row['is_open_24h'] as bool,
              createdAt: DateTime.parse(row['created_at'] as String),
            ),
          )
          .toList();

      return right(stores);
    } on ServerException catch (e) {
      return left(Failures(e.message));
    } catch (e) {
      return left(Failures(e.toString()));
    }
  }
}
