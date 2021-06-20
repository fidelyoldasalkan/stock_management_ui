import 'package:flutter/cupertino.dart';
import 'package:stock_management_ui/constant/ServicePath.dart';
import 'package:stock_management_ui/dto/GeneralResponse.dart';
import 'package:stock_management_ui/util/MyDio.dart';

class DividendService {
  static Future<dynamic> delete(BuildContext buildContext, int id) async {
    await MyDio(buildContext).delete(ServicePath.DIVIDEND_DELETE, id);
  }

  static Future<dynamic> save(BuildContext context, Map<String, dynamic> data, { Function(GeneralResponse? generalResponse)? onSuccess, Function(GeneralResponse? generalResponse)? onError}) async {
    return await MyDio(context).post(ServicePath.DIVIDEND_SAVE, data, onSuccess: onSuccess, onError: onError);
  }
}