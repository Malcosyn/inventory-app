import 'package:inventory_app/core/secrets/supabase_secret.dart';
import 'package:inventory_app/features/auth/data/data_sources/auth_supabase_data_source.dart';
import 'package:inventory_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:inventory_app/features/auth/domain/repository/auth_repository.dart';
import 'package:inventory_app/features/auth/domain/usecases/user_sign_up_usecase.dart';
import 'package:inventory_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> InitDepedencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: SupabaseSecret.supabaseUrl,
    anonKey: SupabaseSecret.supabaseAnonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  serviceLocator.registerFactory<AuthSupabaseDataSource>(
    () => AuthSupabaseDataSourceImpl(supabaseClient: serviceLocator()),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(supabaseDataSource: serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => UserSignUpUsecase(authRepository: serviceLocator()),
  );
  
  serviceLocator.registerLazySingleton(() => AuthBloc(userSignUpUsecase: serviceLocator()));
}
