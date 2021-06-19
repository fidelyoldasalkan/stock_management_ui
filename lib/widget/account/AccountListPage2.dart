import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:stock_management_ui/model/Account.dart';
import 'package:stock_management_ui/util/UrlBuilder.dart';
import 'package:stock_management_ui/widget/abstract/AbstractListPage.dart';
import 'package:stock_management_ui/widget/account/AccountCreatePage2.dart';

class AccountListPage2 extends AbstractListPage<Account> {
  AccountListPage2(String title, String createButtonTitle)
      : super(title, createButtonTitle);

  @override
  Uri apiUri() {
    return UrlBuilder.accountList();
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
  void onError() {
    // TODO: implement onError
  }

  @override
  void onSuccess() {
    // TODO: implement onSuccess
  }

  @override
  void onTapRow(Account data) {
    // TODO: implement onTapRow
  }

  @override
  Widget row(Account data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Card(
          child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            secondaryActions: [
              IconSlideAction(
                caption: 'Sil',
                color: Colors.redAccent,
                icon: Icons.delete,
                onTap: () {},
              )
            ],
            child: Row(
              children: [
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
