import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/config/routes/routes.dart';
import 'package:flutter_bloc_pattern/config/routes/routes_name.dart';
import 'package:flutter_bloc_pattern/repository/auth/login_http_api_repository.dart';
import 'package:flutter_bloc_pattern/repository/auth/login_repository.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;
void main() {
  serviceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      initialRoute: RoutesName.splashScreen,
      onGenerateRoute: Routes.genrateRoutes,
    );
  }
}

void serviceLocator() {
  getIt.registerLazySingleton<LoginRepository>(() => LoginHttpApiRepository());
}
