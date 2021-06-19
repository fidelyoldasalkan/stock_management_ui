import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:stock_management_ui/model/MoneyFlow.dart';
import 'package:stock_management_ui/util/DateUtil.dart';
import 'package:stock_management_ui/util/UrlBuilder.dart';
import 'package:stock_management_ui/widget/abstract/AbstractListPage.dart';
import 'package:stock_management_ui/widget/moneyFlow/MoneyFlowCreatePage.dart';

class MoneyFlowListPage extends AbstractListPage<MoneyFlow> {
  MoneyFlowListPage(String title, String createButtonTitle)
      : super(title, createButtonTitle);

  @override
  Uri apiUri() {
    return UrlBuilder.moneyFlowList();
  }

  @override
  Widget createPage() {
    return MoneyFlowCreatePage();
  }

  @override
  MoneyFlow mapper(Map<String, dynamic> json) {
    return MoneyFlow.fromJson(json);
  }

  @override
  Widget noFoundData() {
    return Text("Nakiş akışıınız bulunmamaktadır");
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
  void onTapRow(MoneyFlow data) {
    // TODO: implement onTapRow
  }

  @override
  Widget row(MoneyFlow data) {
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
                  child: Center(
                    child: data.moneyFlowType == 'DEPOSIT'
                        ? Icon(
                            Icons.arrow_circle_up_rounded,
                            color: Colors.green,
                          )
                        : Icon(
                            Icons.arrow_circle_down_rounded,
                            color: Colors.red,
                          ),
                  ),
                  flex: 1,
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data.accountName!),
                      Text(DateUtil.ddMmYyStr(data.date))
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text("${data.amount}"),
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
