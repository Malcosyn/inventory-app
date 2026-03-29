
import 'package:fpdart/fpdart.dart';
import 'package:inventory_app/core/error/failures.dart';

abstract interface class Usecase<SuccessType, Params> {
  Future<Either<Failures, SuccessType>> call(Params param);
}