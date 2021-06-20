import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:stock_management_ui/dto/GeneralResponse.dart';
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

  Future<GeneralResponse> get(String url, {Function? onSuccess, Function? onError}) async {
    try {
      Response r = await _dio.get(url);
      return GeneralResponse.fromJson(r.data);
    } catch(e) {
      Response r = await _dio.get(url);
      return GeneralResponse.fromJson(r.data);
    }

  }

  Future<Response> post(String url, Map<String, dynamic> data, {Function? onSuccess, Function? onError}) async {
    Response response = await _dio.post(url, data: data);
    GeneralResponse generalResponse = GeneralResponse.fromJson(response.data);
    if (onSuccess != null && response.statusCode == HttpStatus.ok) {
      if (onError != null && generalResponse.status == 'ERROR') {
        onError(generalResponse);
        return response;
      }
      onSuccess(generalResponse);
      return response;
    } else if (onError != null && response.statusCode != HttpStatus.ok) {
      onError(generalResponse);
      return response;
    }
    return response;
  }

  Future<Response> delete(String url, int id, {Function? onSuccess, Function? onError}) async {
    return await _dio.delete("$url/$id");
  }
}