part of 'supplier_bloc.dart';

@immutable
sealed class SupplierEvent {}

final class LoadSuppliers extends SupplierEvent {}
