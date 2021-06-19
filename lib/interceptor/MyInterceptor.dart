import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_management_ui/util/MyDio.dart';
import 'package:stock_management_ui/util/SharedPref.dart';

class MyInterceptor extends Interceptor {
  static SharedPref _sharedPref = SharedPref.getInstance();

  BuildContext buildContext;

  MyInterceptor(this.buildContext);

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String? token = await _sharedPref.loadToken();
    print("REQ");
    options.headers.addAll(
        {"content-type": "application/json", "Authorization": "Bearer $token"});
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response!.statusCode == HttpStatus.forbidden) {
      var username = await _sharedPref.loadUsername();
      var password = await _sharedPref.loadPassword();
      var response = await MyDio(buildContext)
          .post("/auth/login", {'username': username, 'password': password});
      await _sharedPref.saveLoginInfo(
          username!, password!, response.data['data']);
      super.onError(err, handler);
      return;
    }

    showDialog(
        context: buildContext,
        builder: (context) {
          return AlertDialog(
            title: Text("Bir Hata Oluştu"),
            content: Column(
              children: [
                Text("${err.type}"),
                Text("${err.message}"),
                Text("${err.error}"),
                ElevatedButton(
                  child: Text("Tamam"),
                  onPressed: () {},
                ),
              ],
            ),
          );
        });
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print("RES");
    super.onResponse(response, handler);
  }
}
