import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/features/auth/domain/usecases/user_sign_in_usecase.dart';
import 'package:inventory_app/features/auth/domain/usecases/user_sign_up_usecase.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignInUsecase _userSignInUsecase;
  final UserSignUpUsecase _userSignUpUsecase;

  AuthBloc({
    required UserSignInUsecase userSignInUsecase,
    required UserSignUpUsecase userSignUpUsecase,
  }) : _userSignInUsecase = userSignInUsecase,
       _userSignUpUsecase = userSignUpUsecase,
       super(AuthInitial()) {
    on<AuthSignIn>((event, emit) async {
      emit(AuthLoading());
      try {
        final response = await _userSignInUsecase(
          UserSignInParams(email: event.email, password: event.password),
        );

        response.fold(
          (l) => emit(AuthFailure(l.message)),
          (r) => emit(AuthSuccess(uid: r)),
        );
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<AuthSignUp>((event, emit) async {
      emit(AuthLoading());
      final response = await _userSignUpUsecase(
        UserSignUpParams(email: event.email, Password: event.password),
      );

        response.fold(
          (l) => emit(AuthFailure(l.message)),
          (r) => emit(AuthSuccess(uid: r)),
        );
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
  }
}
