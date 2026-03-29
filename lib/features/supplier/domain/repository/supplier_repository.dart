import 'package:fpdart/fpdart.dart';
import 'package:inventory_app/core/error/failures.dart';
import 'package:inventory_app/features/supplier/domain/entity/supplier.dart';

abstract interface class SupplierRepository {
  Future<Either<Failures, List<Supplier>>> getSuppliers();
}
