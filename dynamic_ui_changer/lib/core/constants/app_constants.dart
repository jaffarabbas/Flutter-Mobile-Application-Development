class AppConstants {
  AppConstants._();

  // API
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String apiVersion = 'v1';

  // App
  static const String appName = 'Dynamic UI Changer';
  static const String appVersion = '1.0.0';

  // Cache
  static const int cacheMaxAge = 60 * 60 * 24; // 24 hours in seconds

  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
