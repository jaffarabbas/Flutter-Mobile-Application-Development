import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import '../network/api_client.dart';
import '../constants/app_constants.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Core
  getIt.registerLazySingleton<Logger>(() => Logger(
        printer: PrettyPrinter(
          methodCount: 0,
          errorMethodCount: 5,
          lineLength: 50,
          colors: true,
          printEmojis: true,
        ),
      ));

  // Dio
  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio(BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // Add interceptors
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      error: true,
    ));

    return dio;
  });

  getIt.registerLazySingleton<ApiClient>(
    () => ApiClient(dio: getIt(), logger: getIt()),
  );

  // Register features here
  // Example: getIt.registerFactory<HomeRepository>(() => HomeRepositoryImpl(...));
}
