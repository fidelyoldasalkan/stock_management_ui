import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stock_management_ui/constant/ServicePath.dart';
import 'package:stock_management_ui/model/Dividend.dart';
import 'package:stock_management_ui/widget/abstract/AbstractCard.dart';

import 'DividendListPage.dart';

class DividendCard extends AbstractCard<Dividend> {
  DividendCard() : super("Temettü", ServicePath.DIVIDEND_LIST);

  @override
  Widget leftWidget(Dividend data) {
    return Text("${data.date} | ${data.stock}");
  }

  @override
  Dividend mapper(json) {
    return Dividend.fromJson(json);
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

  @override
  void onPressedCardTitleButton() {
    Navigator.push(buildContext, MaterialPageRoute(builder: (context) => DividendListPage()));
  }
}
