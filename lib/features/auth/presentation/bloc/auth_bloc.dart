import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/features/auth/domain/usecases/user_sign_up_usecase.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUpUsecase _userSignUpUsecase;

  AuthBloc({required UserSignUpUsecase userSignUpUsecase})
    : _userSignUpUsecase = userSignUpUsecase,
      super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      emit(AuthLoading());
      final response = await _userSignUpUsecase(
        UserSignUpParams(email: event.email, Password: event.password),
      );

      response.fold((l) => emit(AuthFailure(l.message)), (r) => emit(AuthSuccess(uid: r)));
    });
  }
}
