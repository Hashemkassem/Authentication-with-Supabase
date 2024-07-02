// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:chat_app/core/api/api_interceptors.dart';
import 'package:chat_app/core/api/end_ponits.dart';
import 'package:dio/dio.dart';

import 'package:chat_app/core/api/api_consumer.dart';

import '../errors/exceptions.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({
    required this.dio,
  }) {
    dio.options.baseUrl = EndPoint.baseUrl;
    dio.interceptors.add(ApiInterceptor());
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
  }

  @override
  Future delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future get(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    try {
      final response = await dio.patch(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  DioConsumer copyWith({
    Dio? dio,
  }) {
    return DioConsumer(
      dio: dio ?? this.dio,
    );
  }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'dio': dio.toMap(),
  //   };
  // }

  // factory DioConsumer.fromMap(Map<String, dynamic> map) {
  //   return DioConsumer(
  //     dio: Dio.fromMap(map['dio'] as Map<String,dynamic>),
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory DioConsumer.fromJson(String source) =>
  //     DioConsumer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DioConsumer(dio: $dio)';

  @override
  bool operator ==(covariant DioConsumer other) {
    if (identical(this, other)) return true;

    return other.dio == dio;
  }

  @override
  int get hashCode => dio.hashCode;
}
