import 'package:flutter/material.dart';
import 'package:stock_management_ui/constant/ServicePath.dart';
import 'package:stock_management_ui/dto/GeneralResponse.dart';
import 'package:stock_management_ui/model/Exchange.dart';
import 'package:stock_management_ui/service/ExchangeService.dart';
import 'package:stock_management_ui/widget/abstract/AbstractListPageState.dart';

import 'ExchangeCreatePage.dart';

class ExchangeListPage extends StatefulWidget {

  @override
  _ExchangeListPageState createState() => _ExchangeListPageState();
}

class _ExchangeListPageState extends AbstractListPageState<Exchange> {

  _ExchangeListPageState() : super("İşlemlerin", "Yeni İşlem");

  @override
  String apiUri() {
    return ServicePath.EXCHANGE_LIST;
  }

  @override
  Widget createPage() {
    return ExchangeCreatePage();
  }

  @override
  Future? delete(int id) async {
    await ExchangeService.delete(context, id);
    return null;
  }

  @override
  mapper(Map<String, dynamic> json) {
    return Exchange.fromJson(json);
  }

  @override
  Widget noFoundData() {
    return Text("Tanımlı işleminiz bulunmamaktadır");
  }

  @override
  void onError(GeneralResponse? generalResponse) {
    // TODO: implement onError
  }

  @override
  void onSuccess(GeneralResponse? generalResponse) {
    // TODO: implement onSuccess
  }

  @override
  void onTapRow(data) {
    // TODO: implement onTapRow
  }

  @override
  List<Widget> row(data) {
    return [
      Expanded(
        flex: 4,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.stock!),
              Text("${data.lot} lot"),
              Text("${data.price} ₺")
            ],
          ),
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
              Text("Tutar ${data.lot! * data.price!}"),
              Text("Komisyon ${data.commission!}"),
            ]
          ),
        ),
      ),
    ];
  }

}
