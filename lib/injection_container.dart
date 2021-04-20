import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:jptapp/features/jptapp/data/datasources/download_data_source.dart';
import 'package:jptapp/features/jptapp/data/datasources/item_local_data_source.dart';
import 'package:jptapp/features/jptapp/data/datasources/pdf_data_source.dart';
import 'package:jptapp/features/jptapp/data/repositories/auth_repository_impl.dart';
import 'package:jptapp/features/jptapp/data/repositories/download_repository_impl.dart';
import 'package:jptapp/features/jptapp/domain/repositories/auth_repository.dart';
import 'package:jptapp/features/jptapp/domain/repositories/download_repository.dart';
import 'package:jptapp/features/jptapp/domain/repositories/pdf_repository.dart';
import 'package:jptapp/features/jptapp/domain/usecases/check_auth.dart';
import 'package:jptapp/features/jptapp/domain/usecases/check_permission.dart';
import 'package:jptapp/features/jptapp/domain/usecases/login.dart';
import 'package:jptapp/features/jptapp/domain/usecases/logout.dart';
import 'package:jptapp/features/jptapp/domain/usecases/start_download.dart';
import 'package:jptapp/features/jptapp/domain/usecases/view_pdf.dart';
import 'package:jptapp/features/jptapp/presentation/bloc/download/download_bloc.dart';
import 'package:jptapp/features/jptapp/presentation/bloc/pdf/pdf_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_themes/stacked_themes.dart';
import 'core/network/network_info.dart';
import 'features/jptapp/data/datasources/item_remote_data_source.dart';
import 'features/jptapp/data/repositories/item_repository_impl.dart';
import 'features/jptapp/data/repositories/pdf_repository_impl.dart';
import 'features/jptapp/domain/repositories/item_repository.dart';
import 'features/jptapp/domain/usecases/get_item.dart';
import 'features/jptapp/presentation/bloc/auth/auth_bloc.dart';
import 'features/jptapp/presentation/bloc/item/item_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Features - Items
  //Bloc
  sl.registerLazySingleton(() => ItemBloc(item: sl()));
  sl.registerLazySingleton(
      () => AuthBloc(login: sl(), logout: sl(), checkAuth: sl()));
  sl.registerLazySingleton(() => PdfBloc(viewPdf: sl()));
  sl.registerLazySingleton(
      () => DownloadBloc(startDownload: sl(), checkPermission: sl()));

  //Use cases
  sl.registerLazySingleton(() => GetItem(sl()));
  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton(() => Logout(sl()));
  sl.registerLazySingleton(() => CheckAuth(sl()));
  sl.registerLazySingleton(() => ViewPdf(sl()));
  sl.registerLazySingleton(() => StartDownload(sl()));
  sl.registerLazySingleton(() => CheckPermission(sl()));

  //repository
  sl.registerLazySingleton<ItemRepository>(() => ItemRepositoryImpl(
      localDataSource: sl(), remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(firebaseAuth: sl(), networkInfo: sl()));
  sl.registerLazySingleton<PdfRepository>(
      () => PdfRepositoryImpl(pdfDataSource: sl()));
  sl.registerLazySingleton<DownloadRepository>(() =>
      DownloadRepositoryImpl(downloadDataSource: sl(), networkInfo: sl()));

  //data sources
  sl.registerLazySingleton<ItemRemoteDataSource>(
      () => ItemRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<ItemLocalDataSource>(
      () => ItemLocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<PdfDataSource>(() => PdfDataSourceImpl());

  sl.registerLazySingleton<DownloadDataSource>(
      () => DownloadDataSourceImpl(dio: sl()));

  //Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      sl(),
    ),
  );

  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => ThemeService.getInstance());
}
