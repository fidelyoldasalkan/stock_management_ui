import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:stock_management_ui/constant/ServicePath.dart';
import 'package:stock_management_ui/model/Account.dart';
import 'package:stock_management_ui/widget/abstract/AbstractCard.dart';

import 'AccountDetailPage.dart';
import 'AccountListPage.dart';

class AccountCard extends AbstractCard<Account> {
  AccountCard() : super("Hesaplar", ServicePath.ACCOUNT_LIST);

  @override
  Account mapper(json) {
    return Account.fromJson(json);
  }

  @override
  Widget leftWidget(Account data) {
    return Text(data.name!);
  }

  @override
  Widget rightWidget(Account data) {
    return Text("${data.commissionRate}");
  }

  @override
  void onRowTap(Account data) {
    Navigator.push(buildContext, MaterialPageRoute(builder: (context) => AccountDetailPage(data)));
  }

  @override
  Widget noFoundDataWidget() {
    return Text("Tanımlı hesabınınz bulunmamaktadır. Lütfen Hesap oluşturunuz");
  }

  @override
  void onPressedCardTitleButton() {
    Navigator.push(buildContext, MaterialPageRoute(builder: (context) => AccountListPage()));
  }
}
