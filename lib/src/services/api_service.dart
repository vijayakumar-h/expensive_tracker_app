import 'package:expensive_tracker_app/common_exports.dart';

/// Singletons start here:
/// [ApiService] is managed as a GetIt Singleton across the entire application lifecycle.
/// It provides HTTP request services using [Dio] and dynamically updates the `Accept-Language`
/// header whenever the global locale changes.
class ApiService {
  late final Dio _dio;

  ApiService({Dio? dio}) {
    _dio = dio ??
        Dio(
          BaseOptions(
            baseUrl: 'https://api.expensetracker.com/v1',
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            headers: {
              'Content-Type': 'application/json',
              'Accept-Language': 'en',
            },
          ),
        );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (kDebugMode) {
            print('[ApiService] Request: ${options.method} ${options.path}');
            print('[ApiService] Headers: ${options.headers}');
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
            print('[ApiService] Response [${response.statusCode}]');
          }
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          if (kDebugMode) {
            print('[ApiService] Error: ${error.message}');
          }
          return handler.next(error);
        },
      ),
    );
  }

  /// Updates `Accept-Language` header dynamically for all HTTP requests
  void setLanguage(String langCode) {
    _dio.options.headers['Accept-Language'] = langCode;
    if (kDebugMode) {
      print('[ApiService] Updated Accept-Language header to: $langCode');
    }
  }

  /// Exposed headers map getter
  Map<String, dynamic> get headers => Map.unmodifiable(_dio.options.headers);

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Options? options,
  }) async {
    return await _dio.post<T>(
      path,
      data: data,
      options: options,
    );
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Options? options,
  }) async {
    return await _dio.delete<T>(
      path,
      data: data,
      options: options,
    );
  }
}
