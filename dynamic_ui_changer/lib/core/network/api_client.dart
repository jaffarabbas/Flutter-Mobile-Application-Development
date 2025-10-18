import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../errors/exceptions.dart';

class ApiClient {
  final Dio _dio;
  final Logger _logger;

  ApiClient({
    required Dio dio,
    required Logger logger,
  })  : _dio = dio,
        _logger = logger;

  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return response.data as T;
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  Future<T> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response.data as T;
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  Future<T> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response.data as T;
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  Future<T> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response.data as T;
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  void _handleDioError(DioException error) {
    _logger.e('DioError: ${error.type} - ${error.message}');

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw NetworkException(message: 'Connection timeout');
      case DioExceptionType.badResponse:
        throw ServerException(
          message: error.response?.data?['message'] ?? 'Server error',
        );
      case DioExceptionType.cancel:
        throw const NetworkException(message: 'Request cancelled');
      case DioExceptionType.connectionError:
        throw NetworkException(message: 'No internet connection');
      case DioExceptionType.badCertificate:
        throw const NetworkException(message: 'Bad certificate');
      case DioExceptionType.unknown:
        throw NetworkException(message: error.message ?? 'Unknown error');
    }
  }
}
