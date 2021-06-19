import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'SharedPref.dart';

class HttpUtil {

  static SharedPref _sharedPref = SharedPref();

  static Future<dynamic> post(Uri uri, Map<String, dynamic> jsonMap, GestureTapCallback onSuccess, GestureTapCallback onError) async {
    String? token = await _sharedPref.loadToken();
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(uri);
    request.headers.set('content-type', 'application/json');
    if (token != null) {
      request.headers.set("Authorization", "Bearer $token");
    }
    
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();


    if (response.statusCode == HttpStatus.ok) {
      String jsonStr = await response.transform(utf8.decoder).join();
      var jsonData = json.decode(jsonStr);
      if (token == null) {
        _sharedPref.saveLoginInfo(jsonMap['username'], jsonMap['password'], jsonData['data']);
      }
      onSuccess();
      print(jsonData['token']);
      return jsonData;
    } else {
      print("${uri.toString()}");
      onError();
    }
    httpClient.close();
    return null;
  }

  static Future<dynamic> get(Uri uri, GestureTapCallback onSuccess, GestureTapCallback onError) async {
    String? token = await _sharedPref.loadToken();
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.getUrl(uri);
    request.headers.set('content-type', 'application/json');
    if (token != null) {
      request.headers.set("Authorization", "Bearer $token");
    }

    HttpClientResponse response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      String jsonStr = await response.transform(utf8.decoder).join();
      var jsonData = json.decode(jsonStr);
      onSuccess();
      print(jsonStr);
      return jsonData;
    } else {
      print("${uri.toString()}");
      onError();
    }
    httpClient.close();
    return null;
  }

  static Future<dynamic> delete(Uri uri, GestureTapCallback onSuccess, GestureTapCallback onError) async {
    String? token = await _sharedPref.loadToken();
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.deleteUrl(uri);
    request.headers.set('content-type', 'application/json');
    if (token != null) {
      request.headers.set("Authorization", "Bearer $token");
    }

    HttpClientResponse response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      String jsonStr = await response.transform(utf8.decoder).join();
      var jsonData = json.decode(jsonStr);
      onSuccess();
      print(jsonStr);
      return jsonData;
    } else {
      print("${uri.toString()}");
      onError();
    }
    httpClient.close();
    return null;
  }
}