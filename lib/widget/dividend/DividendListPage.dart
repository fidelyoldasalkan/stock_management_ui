import 'package:flutter/material.dart';
import 'package:stock_management_ui/model/Dividend.dart';
import 'package:stock_management_ui/util/UrlBuilder.dart';
import 'package:stock_management_ui/widget/abstract/AbstractListPage.dart';
import 'package:stock_management_ui/widget/dividend/DividendCreatePage.dart';

class DividendListPage extends AbstractListPage<Dividend> {
  DividendListPage(String title, String createButtonTitle) : super(title, createButtonTitle);

  @override
  Uri apiUri() {
    return UrlBuilder.dividendList();
  }

  @override
  Widget createPage() {
    return DividendCreatePage();
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
  Widget row(Dividend data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Text("${data.stock}"),
        ),
        Container(
          child: Text("${data.lot! * data.amount!} ₺"),
        )
      ],
    );
  }

}