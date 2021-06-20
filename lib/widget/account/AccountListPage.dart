import 'package:flutter/material.dart';
import 'package:stock_management_ui/constant/ServicePath.dart';
import 'package:stock_management_ui/dto/GeneralResponse.dart';
import 'package:stock_management_ui/model/Account.dart';
import 'package:stock_management_ui/service/AccountService.dart';
import 'package:stock_management_ui/widget/abstract/AbstractListPageState.dart';

import 'AccountCreatePage.dart';
import 'AccountDetailPage.dart';

class AccountListPage extends StatefulWidget {
  @override
  _AccountListPageState createState() => _AccountListPageState();
}

class _AccountListPageState extends AbstractListPageState<Account> {
  _AccountListPageState() : super("Hesaplarım", "Hesap Ekle");

  @override
  String apiUri() {
    return ServicePath.ACCOUNT_LIST;
  }

  @override
  Widget createPage() {
    return AccountCreatePage("Hesap Ekle");
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
    Navigator.push(context, MaterialPageRoute(builder: (context) => AccountDetailPage(data)));
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

  @override
  void edit(Account data) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AccountCreatePage("Hesap Düzenle", account: data,)));
  }
}
