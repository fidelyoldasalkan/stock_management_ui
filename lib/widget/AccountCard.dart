import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stock_management_ui/model/Account.dart';
import 'package:stock_management_ui/util/UrlBuilder.dart';
import 'package:stock_management_ui/widget/AbstractCard.dart';

class AccountCard extends AbstractCard<Account> {
  AccountCard() : super("Hesaplar", UrlBuilder.build("account/list"));

  @override
  Account mapper(json) {
    return Account(json['id'], json['name'], json['corporationId'],
        json['commissionRate']);
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
    // TODO: implement onRowTap
  }

  @override
  Widget noFoundDataWidget() {
    return Text("Tanımlı hesabınınz bulunmamaktadır. Lütfen Hesap oluşturunuz");
  }
}
