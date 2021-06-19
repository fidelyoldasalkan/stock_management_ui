import 'package:flutter/material.dart';
import 'package:stock_management_ui/model/MoneyFlow.dart';
import 'package:stock_management_ui/service/MoneyFlowService.dart';
import 'package:stock_management_ui/util/DateUtil.dart';
import 'package:stock_management_ui/util/UrlBuilder.dart';
import 'package:stock_management_ui/widget/abstract/AbstractListPageState.dart';

import 'MoneyFlowCreatePage.dart';

class MoneyFlowListPage extends StatefulWidget {
  const MoneyFlowListPage({Key? key}) : super(key: key);

  @override
  _MoneyFlowListPageState createState() => _MoneyFlowListPageState();
}

class _MoneyFlowListPageState extends AbstractListPageState<MoneyFlow> {

  _MoneyFlowListPageState() : super("Nakit Akışı", "Nakit Akışı Ekle");

  @override
  Uri apiUri() {
    return UrlBuilder.moneyFlowList();
  }

  @override
  Widget createPage() {
    return MoneyFlowCreatePage();
  }

  @override
  Future? delete(int id) async {
    await MoneyFlowService.delete(id);
    return null;
  }

  @override
  MoneyFlow mapper(Map<String, dynamic> json) {
    return MoneyFlow.fromJson(json);
  }

  @override
  Widget noFoundData() {
    return Text("Nakiş akışıınız bulunmamaktadır");
  }

  @override
  void onError() {
    // TODO: implement onError
  }

  @override
  void onSuccess() {
    // TODO: implement onSuccess
  }

  @override
  void onTapRow(MoneyFlow data) {
    // TODO: implement onTapRow
  }

  @override
  List<Widget> row(MoneyFlow data) {
    return [
      Expanded(
        child: Center(
          child: data.moneyFlowType == 'DEPOSIT'
              ? Icon(
            Icons.arrow_circle_up_rounded,
            color: Colors.green,
          )
              : Icon(
            Icons.arrow_circle_down_rounded,
            color: Colors.red,
          ),
        ),
        flex: 1,
      ),
      Expanded(
        flex: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data.accountName!),
            Text(DateUtil.ddMmYyStr(data.date))
          ],
        ),
      ),
      Expanded(
        child: Center(
          child: Text("${data.amount}"),
        ),
      ),
    ];
  }
}
