import 'package:inventory_app/core/secrets/supabase_secret.dart';
import 'package:inventory_app/features/auth/data/data_sources/auth_supabase_data_source.dart';
import 'package:inventory_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:inventory_app/features/auth/domain/repository/auth_repository.dart';
import 'package:inventory_app/features/auth/domain/usecases/user_sign_in_usecase.dart';
import 'package:inventory_app/features/auth/domain/usecases/user_sign_up_usecase.dart';
import 'package:inventory_app/features/auth/presentation/bloc/auth_bloc.dart';
// Product imports
import 'package:inventory_app/features/product/data/data_sources/product_supabase_data_source.dart';
import 'package:inventory_app/features/product/data/repository/product_repository_impl.dart';
import 'package:inventory_app/features/product/domain/repository/product_repository.dart';
import 'package:inventory_app/features/product/domain/usecases/get_products_usecase.dart';
import 'package:inventory_app/features/product/presentation/bloc/product_bloc.dart';
// Inventory imports
import 'package:inventory_app/features/inventory/data/data_sources/inventory_supabase_data_source.dart';
import 'package:inventory_app/features/inventory/data/repository/inventory_repository_impl.dart';
import 'package:inventory_app/features/inventory/domain/repository/inventory_repository.dart';
import 'package:inventory_app/features/inventory/domain/usecases/get_inventory_usecase.dart';
import 'package:inventory_app/features/inventory/presentation/bloc/inventory_bloc.dart';
// Order imports
import 'package:inventory_app/features/order/data/data_sources/order_supabase_data_source.dart';
import 'package:inventory_app/features/order/data/repository/order_repository_impl.dart';
import 'package:inventory_app/features/order/domain/repository/order_repository.dart';
import 'package:inventory_app/features/order/domain/usecases/get_orders_usecase.dart';
import 'package:inventory_app/features/order/presentation/bloc/order_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initProduct();
  _initInventory();
  _initOrder();
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

  serviceLocator.registerFactory(
    () => UserSignInUsecase(authRepository: serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignInUsecase: serviceLocator(),
      userSignUpUsecase: serviceLocator(),
    ),
  );
}

void _initProduct() {
  serviceLocator.registerFactory<ProductSupabaseDataSource>(
    () => ProductSupabaseDataSourceImpl(supabaseClient: serviceLocator()),
  );

  serviceLocator.registerFactory<ProductRepository>(
    () => ProductRepositoryImpl(productSupabaseDataSource: serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => GetProductsUsecase(productRepository: serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () => ProductBloc(getProductsUsecase: serviceLocator()),
  );
}

void _initInventory() {
  serviceLocator.registerFactory<InventorySupabaseDataSource>(
    () => InventorySupabaseDataSourceImpl(supabaseClient: serviceLocator()),
  );

  serviceLocator.registerFactory<InventoryRepository>(
    () =>
        InventoryRepositoryImpl(inventorySupabaseDataSource: serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => GetInventoryUsecase(inventoryRepository: serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () => InventoryBloc(getInventoryUsecase: serviceLocator()),
  );
}

void _initOrder() {
  serviceLocator.registerFactory<OrderSupabaseDataSource>(
    () => OrderSupabaseDataSourceImpl(supabaseClient: serviceLocator()),
  );

  serviceLocator.registerFactory<OrderRepository>(
    () => OrderRepositoryImpl(orderSupabaseDataSource: serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => GetOrdersUsecase(orderRepository: serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () => OrderBloc(getOrdersUsecase: serviceLocator()),
  );
}
