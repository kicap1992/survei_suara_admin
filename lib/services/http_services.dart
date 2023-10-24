import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MyHttpServices {
  final _options = BaseOptions(
    baseUrl: dotenv.env['api_url']!,
    connectTimeout: const Duration(milliseconds: 60000),
    receiveTimeout: const Duration(milliseconds: 60000),
  );

  late Dio _dio;

  MyHttpServices() {
    _dio = Dio(_options);
  }

  Future<Response> get(String path) async {
    try {
      return await _dio.get(path);
    } on DioException {
      rethrow;
    }
  }

  Future<Response> postWithFormData(String path, FormData formData) async {
    try {
      return await _dio.post(path, data: formData);
    } on DioException {
      rethrow;
    }
  }

  Future<Response> delete(String path) async {
    try {
      return await _dio.delete(path);
    } on DioException {
      rethrow;
    }
  }
}
