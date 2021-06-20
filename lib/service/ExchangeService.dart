import 'package:flutter/cupertino.dart';
import 'package:stock_management_ui/constant/ServicePath.dart';
import 'package:stock_management_ui/dto/GeneralResponse.dart';
import 'package:stock_management_ui/util/MyDio.dart';

class ExchangeService {
  static Future<dynamic> delete(BuildContext buildContext, int id) async {
    await MyDio(buildContext).delete(ServicePath.ACCOUNT_DELETE, id);
  }

  static Future<dynamic> save(BuildContext context, Map<String, dynamic> json, {void Function(GeneralResponse? generalResponse)? onSuccess, void Function(GeneralResponse? generalResponse)? onError}) async {
    return await MyDio(context).post(ServicePath.EXCHANGE_SAVE, json, onSuccess: onSuccess, onError: onError);
  }
}
