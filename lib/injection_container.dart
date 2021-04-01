import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:jptapp/features/jptapp/data/datasources/item_local_data_source.dart';
import 'package:jptapp/features/jptapp/data/repositories/auth_repository_impl.dart';
import 'package:jptapp/features/jptapp/domain/repositories/auth_repository.dart';
import 'package:jptapp/features/jptapp/domain/usecases/check_auth.dart';
import 'package:jptapp/features/jptapp/domain/usecases/login.dart';
import 'package:jptapp/features/jptapp/domain/usecases/logout.dart';
import 'package:jptapp/features/jptapp/presentation/bloc/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/network/network_info.dart';
import 'features/jptapp/data/datasources/item_remote_data_source.dart';
import 'features/jptapp/data/repositories/item_repository_impl.dart';
import 'features/jptapp/domain/repositories/item_repository.dart';
import 'features/jptapp/domain/usecases/get_item.dart';
import 'features/jptapp/presentation/bloc/item_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Features - Items
  //Bloc
  sl.registerLazySingleton(() => ItemBloc(item: sl()));
  sl.registerLazySingleton(
      () => AuthBloc(login: sl(), logout: sl(), checkAuth: sl()));

  //Use cases
  sl.registerLazySingleton(() => GetItem(sl()));
  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton(() => Logout(sl()));
  sl.registerLazySingleton(() => CheckAuth(sl()));

  //repository
  sl.registerLazySingleton<ItemRepository>(() => ItemRepositoryImpl(
      localDataSource: sl(), remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(firebaseAuth: sl()));

  //data sources
  sl.registerLazySingleton<ItemRemoteDataSource>(
      () => ItemRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<ItemLocalDataSource>(
      () => ItemLocalDataSourceImpl(sharedPreferences: sl()));

  //Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      sl(),
    ),
  );

  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => FirebaseAuth.instance);
}
