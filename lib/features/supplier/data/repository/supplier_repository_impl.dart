import 'package:fpdart/fpdart.dart';
import 'package:inventory_app/core/error/failures.dart';
import 'package:inventory_app/features/supplier/data/data_sources/supplier_supabase_data_source.dart';
import 'package:inventory_app/features/supplier/data/model/supplier_model.dart';
import 'package:inventory_app/features/supplier/domain/entity/supplier.dart';
import 'package:inventory_app/features/supplier/domain/repository/supplier_repository.dart';

class SupplierRepositoryImpl implements SupplierRepository {
  final SupplierSupabaseDataSource supplierSupabaseDataSource;

  SupplierRepositoryImpl({required this.supplierSupabaseDataSource});

  @override
  Future<Either<Failures, List<Supplier>>> getSuppliers() async {
    try {
      final rows = await supplierSupabaseDataSource.getSuppliers();
      return right(rows.map(SupplierModel.fromMap).toList());
    } catch (e) {
      return left(Failures(e.toString()));
    }
  }
}
