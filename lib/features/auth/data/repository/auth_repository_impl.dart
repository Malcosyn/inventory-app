import 'package:fpdart/fpdart.dart';
import 'package:inventory_app/core/error/exception.dart';
import 'package:inventory_app/core/error/failures.dart';
import 'package:inventory_app/features/auth/data/data_sources/auth_supabase_data_source.dart';
import 'package:inventory_app/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthSupabaseDataSource supabaseDataSource;

  const AuthRepositoryImpl({required this.supabaseDataSource});

  @override
  Future<Either<Failures, String>> signInWithEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement signInWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, String>> signUpWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userId = await supabaseDataSource.signUpWithEmailPassword(
        email: email,
        password: password,
      );

      return right(userId);
    }on ServerException catch (e) {
      return left(Failures(e.message));
    }
  }
}
