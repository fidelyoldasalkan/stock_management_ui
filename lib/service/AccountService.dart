import 'package:flutter/cupertino.dart';
import 'package:stock_management_ui/constant/ServicePath.dart';
import 'package:stock_management_ui/model/Account.dart';
import 'package:stock_management_ui/util/HttpUtil.dart';
import 'package:stock_management_ui/util/MyDio.dart';
import 'package:stock_management_ui/util/UrlBuilder.dart';

class AccountService {

  static Future<List<Account>> list(BuildContext buildContext) async {
    var response = await MyDio(buildContext).get(ServicePath.ACCOUNT_LIST);

    List<Account> list = [];
    for (var json in response.data!) {
      list.add(Account.fromJson(json));
    }

    return list;
  }

  static Future<dynamic> delete(int id) async {
    await HttpUtil.delete(UrlBuilder.accountDelete(id), () { }, () { });
  }
}