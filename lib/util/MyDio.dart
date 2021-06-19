import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:stock_management_ui/interceptor/MyInterceptor.dart';

class MyDio {

  late Dio _dio;
  BuildContext buildContext;

  MyDio(this.buildContext) {
    _dio = Dio(
        BaseOptions(
            baseUrl: "http://192.168.1.107:8080",
            connectTimeout: 30000,
            receiveTimeout: 30000
        )
    );
    _dio.interceptors.add(MyInterceptor(this.buildContext));
  }

  Future<Response> get(String url) async {
    try {
      Response response = await _dio.get(url);
      return response;
    } catch(e) {
      Response response = await _dio.get(url);
      return response;
    }

  }

  Future<Response> post(String url, Map<String, dynamic> data) async {
    Response response = await _dio.post(url, data: data);
    return response;
  }

}