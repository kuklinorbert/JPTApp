import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:jptapp/features/jptapp/data/datasources/item_local_data_source.dart';
import 'package:jptapp/features/jptapp/data/datasources/login_user_data_source.dart';
import 'package:jptapp/features/jptapp/data/repositories/login_repository_impl.dart';
import 'package:jptapp/features/jptapp/domain/repositories/login_repository.dart';
import 'package:jptapp/features/jptapp/domain/usecases/login.dart';
import 'package:jptapp/features/jptapp/presentation/bloc/login_bloc.dart';
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
  sl.registerLazySingleton(() => LoginBloc(sl()));

  //Use cases
  sl.registerLazySingleton(() => GetItem(sl()));
  sl.registerLazySingleton(() => Login(sl()));

  //repository
  sl.registerLazySingleton<ItemRepository>(() => ItemRepositoryImpl(
      localDataSource: sl(), remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(sl()));

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
  sl.registerLazySingleton<LoginUser>(() => LoginUserImpl());
}
