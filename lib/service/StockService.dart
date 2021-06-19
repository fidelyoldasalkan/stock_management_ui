import 'package:flutter/cupertino.dart';
import 'package:stock_management_ui/constant/ServicePath.dart';
import 'package:stock_management_ui/model/Stock.dart';
import 'package:stock_management_ui/util/MyDio.dart';

class StockService {

  static Future<List<Stock>> list(BuildContext buildContext) async {
    final response = await MyDio(buildContext).get(ServicePath.STOCK_LIST);

    List<Stock> list = [];
    for (var json in response.data!) {
      list.add(Stock.fromJson(json));
    }

    return list;
  }

}