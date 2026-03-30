import 'package:fpdart/fpdart.dart';
import 'package:inventory_app/core/error/failures.dart';
import 'package:inventory_app/core/usecases/usecase.dart';
import 'package:inventory_app/features/auth/domain/repository/auth_repository.dart';

class UserSignUpUsecase implements Usecase<String, UserSignUpParams> {
  final AuthRepository authRepository;

  const UserSignUpUsecase({required this.authRepository});

  @override
  Future<Either<Failures, String>> call(UserSignUpParams param) async {
    return await authRepository.signUpWithEmailPassword(
      email: param.email,
      password: param.password,
    );
  }
}

class UserSignUpParams {
  final String email;
  final String password;

  UserSignUpParams({required this.email, required this.password});
}
