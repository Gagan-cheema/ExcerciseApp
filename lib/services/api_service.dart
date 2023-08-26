import 'dart:io';

import 'package:dio/dio.dart';
import 'package:exercise_app/constants/endpoints.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();

  factory ApiService() => _instance;

  ApiService._internal();

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Endpoint.baseUrl,
      headers: {Endpoint.headerAuthKey: Endpoint.apiKey},
      connectTimeout: const Duration(milliseconds: 15000),
      receiveTimeout: const Duration(milliseconds: 15000),
      sendTimeout: const Duration(milliseconds: 15000),
      responseType: ResponseType.json,
    ),
  )..interceptors.add(
      PrettyDioLogger(
        compact: false,
        request: true,
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        error: true,
      ),
    );

  // Get:-----------------------------------------------------------------------
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final Response response = await _dio.get(
      url,
      queryParameters: queryParameters,
    );

    if (response.statusCode == HttpStatus.ok) {
      return response;
    } else {
      throw DioException(
        response: response,
        requestOptions: response.requestOptions,
      );
    }
  }
}
