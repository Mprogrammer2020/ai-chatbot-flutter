import 'package:dio/dio.dart';

import 'endpoints.dart';

class DioClient {
// dio instance
  final Dio _dio=Dio(BaseOptions(
    baseUrl: Endpoints.baseUrl,
    connectTimeout: Endpoints.connectionTimeout,
    receiveTimeout: Endpoints.receiveTimeout,
    responseType: ResponseType.json,
    headers: <String,String>{
      "Content-Type":"application/json",
      // "Authorization":"Bearer <chatGpt-Api-Key>",
      "Authorization":"<chatGpt-Api-Key>",
      // "Authorization":"Bearer <chatGpt-Api-Key>",
  }
  ));


  // Get:-----------------------------------------------------------------------
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Post:----------------------------------------------------------------------
  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
