import 'package:fpdart/fpdart.dart';
import 'package:inventory_app/core/error/failures.dart';
import 'package:inventory_app/core/usecases/usecase.dart';
import 'package:inventory_app/features/auth/domain/repository/auth_repository.dart';

class UserSignInUsecase implements Usecase<String, UserSignInParams> {
  final AuthRepository authRepository;

  const UserSignInUsecase({required this.authRepository});

  @override
  Future<Either<Failures, String>> call(UserSignInParams param) async {
    return authRepository.signInWithEmailPassword(
      email: param.email,
      password: param.password,
    );
  }
}

class UserSignInParams {
  final String email;
  final String password;

  UserSignInParams({required this.email, required this.password});
}
