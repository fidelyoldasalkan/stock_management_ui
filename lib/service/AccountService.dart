import 'package:flutter/cupertino.dart';
import 'package:stock_management_ui/constant/ServicePath.dart';
import 'package:stock_management_ui/model/Account.dart';
import 'package:stock_management_ui/util/MyDio.dart';

class AccountService {

  static Future<List<Account>> list(BuildContext buildContext) async {
    var response = await MyDio(buildContext).get(ServicePath.ACCOUNT_LIST);

    List<Account> list = [];
    for (var json in response.data!) {
      list.add(Account.fromJson(json));
    }

    return list;
  }

  static Future<dynamic> delete(BuildContext buildContext, int id) async {
    return await MyDio(buildContext).delete(ServicePath.ACCOUNT_DELETE, id);
  }

  static Future<dynamic> save(BuildContext buildContext, dynamic data, {Function? onSuccess, Function? onError}) async {
    return await MyDio(buildContext).post(ServicePath.ACCOUNT_SAVE, data, onSuccess: onSuccess, onError: onError);
  }

  static Future<dynamic> detail(BuildContext context, int id) async {
    return await MyDio(context).get(ServicePath.ACCOUNT_DETAIL + "/$id");
  }

}