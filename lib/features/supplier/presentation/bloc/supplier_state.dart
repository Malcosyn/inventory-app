part of 'supplier_bloc.dart';

@immutable
sealed class SupplierState {}

final class SupplierInitial extends SupplierState {}

final class SupplierLoading extends SupplierState {}

final class SupplierLoaded extends SupplierState {
  final List<Supplier> suppliers;

  SupplierLoaded(this.suppliers);
}

final class SupplierFailure extends SupplierState {
  final String message;

  SupplierFailure(this.message);
}
