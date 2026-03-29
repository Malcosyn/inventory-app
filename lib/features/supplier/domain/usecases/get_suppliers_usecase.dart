import 'package:fpdart/fpdart.dart';
import 'package:inventory_app/core/error/failures.dart';
import 'package:inventory_app/core/usecases/usecase.dart';
import 'package:inventory_app/features/supplier/domain/entity/supplier.dart';
import 'package:inventory_app/features/supplier/domain/repository/supplier_repository.dart';

class GetSuppliersUsecase implements Usecase<List<Supplier>, NoSupplierParams> {
  final SupplierRepository supplierRepository;

  GetSuppliersUsecase({required this.supplierRepository});

  @override
  Future<Either<Failures, List<Supplier>>> call(NoSupplierParams param) {
    return supplierRepository.getSuppliers();
  }
}

class NoSupplierParams {}
