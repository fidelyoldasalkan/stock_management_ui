import 'package:flutter/material.dart';
import 'package:stock_management_ui/constant/ServicePath.dart';
import 'package:stock_management_ui/dto/GeneralResponse.dart';
import 'package:stock_management_ui/model/Account.dart';
import 'package:stock_management_ui/service/AccountService.dart';
import 'package:stock_management_ui/widget/abstract/AbstractListPageState.dart';

import 'AccountCreatePage2.dart';

class AccountListPage3 extends StatefulWidget {
  @override
  _AccountListPage3State createState() => _AccountListPage3State();
}

class _AccountListPage3State extends AbstractListPageState<Account> {
  _AccountListPage3State() : super("Hesaplarım", "Hesap Ekle");

  @override
  String apiUri() {
    return ServicePath.ACCOUNT_LIST;
  }

  @override
  Widget createPage() {
    return AccountCreatePage2();
  }

  @override
  Account mapper(Map<String, dynamic> json) {
    return Account.fromJson(json);
  }

  @override
  Widget noFoundData() {
    return Text("Tanımlı hesabınız bulunmamaktadır");
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
  void onTapRow(Account data) {
    // TODO: implement onTapRow
  }

  @override
  List<Widget> row(Account data) {
    return [
      Expanded(
        flex: 4,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.name!),
            ],
          ),
        ),
      ),
      Expanded(
        child: Center(
          child: Text("${data.amount!}"),
        ),
      ),
    ];
  }

  @override
  Future? delete(int id) async {
    await AccountService.delete(context, id);
    return null;
  }
}
