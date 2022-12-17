import 'dart:io';
import 'package:dio/dio.dart';


enum Method { get, put, post, delete }

Future<dynamic> fetch(String url, Method method, BaseOptions options,
    {Map<String, dynamic>? queryParams, Map<String, dynamic>? data}) async {
  final client =  Dio();
  client.options = options;

  Response response;
  try {
    switch (method) {
      case Method.get:
        response = await client.get(url, queryParameters: queryParams);
        break;
      case Method.put:
        response =
        await client.put(url, queryParameters: queryParams, data: data);
        break;
      case Method.post:
        response =
        await client.post(url, queryParameters: queryParams, data: data);
        break;
      case Method.delete:
        response = await client.delete(url, queryParameters: queryParams);
        break;
    }
    if (response.statusCode == HttpStatus.ok) {
      return response.data;
    }else {
      throw Exception(
          '${response.statusMessage} ${response.statusCode}  $url');
    }
  } catch (error) {
    if (error is DioError) {
      throw Exception(
          '${error.message} ${error.type} ${error.error} $url');
    }else{
      rethrow;
    }
  }
}
