import 'package:flutter/material.dart';
import 'package:stock_management_ui/constant/ServicePath.dart';
import 'package:stock_management_ui/model/Corporation.dart';
import 'package:stock_management_ui/util/MyDio.dart';

class CorporationService {

  static Future<List<Corporation>> list(BuildContext buildContext) async {
    var response = await MyDio(buildContext).get(ServicePath.CORPORATION_LIST);

    List<Corporation> list = [];
    for (var json in response.data!) {
      list.add(Corporation.fromJson(json));
    }

    return list;
  }
}