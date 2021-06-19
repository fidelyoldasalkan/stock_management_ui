import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stock_management_ui/model/Dividend.dart';
import 'package:stock_management_ui/util/UrlBuilder.dart';
import 'package:stock_management_ui/widget/AbstractCard.dart';

class DividendCard extends AbstractCard<Dividend> {
  DividendCard() : super("Temettü", UrlBuilder.build("dividend/list"));

  @override
  Widget leftWidget(Dividend data) {
    return Text("${data.date} | ${data.stock}");
  }

  @override
  Dividend mapper(json) {
    return Dividend(
        0,
        json['accountId'],
        json['date'],
        json['stock'],
        json['lot'],
        json['amount']);
  }

  @override
  Widget noFoundDataWidget() {
    return Text("Temettü işleminiz bulunmamaktadır");
  }

  @override
  void onRowTap(Dividend data) {
    // TODO: implement onRowTap
  }

  @override
  Widget rightWidget(Dividend data) {
    return Text("${data.lot! * data.amount!} ₺");
  }
}
