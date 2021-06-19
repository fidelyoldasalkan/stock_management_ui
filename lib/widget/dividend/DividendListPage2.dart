import 'package:flutter/cupertino.dart';
import 'package:stock_management_ui/model/Dividend.dart';
import 'package:stock_management_ui/service/DividendService.dart';
import 'package:stock_management_ui/util/UrlBuilder.dart';
import 'package:stock_management_ui/widget/abstract/AbstractListPageState.dart';

import 'DividendCreatePage.dart';

class DividendListPage2 extends StatefulWidget {
  @override
  _DividendListPage2State createState() => _DividendListPage2State();
}

class _DividendListPage2State extends AbstractListPageState<Dividend> {
  _DividendListPage2State() : super("Temettülerim", "Temettü Ekle");

  @override
  Uri apiUri() {
    return UrlBuilder.dividendList();
  }

  @override
  Widget createPage() {
    return DividendCreatePage();
  }

  @override
  Future? delete(int id) async {
    await DividendService.delete(id);
    return null;
  }

  @override
  Dividend mapper(Map<String, dynamic> json) {
    return Dividend.fromJson(json);
  }

  @override
  Widget noFoundData() {
    return Text("Temettü işleminiz bulunmamaktadır");
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
  void onTapRow(Dividend data) {
    // TODO: implement onTapRow
  }

  @override
  List<Widget> row(Dividend data) {
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
            ],
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: Center(
          child: Text("${data.lot! * data.amount!}"),
        ),
      )
    ];
  }
}
