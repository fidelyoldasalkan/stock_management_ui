import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stock_management_ui/constant/ServicePath.dart';
import 'package:stock_management_ui/model/MoneyFlow.dart';
import 'package:stock_management_ui/widget/abstract/AbstractCard.dart';

import 'MoneyFlowListPage.dart';

class MoneyFlowCard extends AbstractCard<MoneyFlow> {
  MoneyFlowCard() : super('Nakit Akışı', ServicePath.MONEY_FLOW_LIST);

  @override
  MoneyFlow mapper(json) {
    return MoneyFlow.fromJson(json);
  }

  @override
  Widget leftWidget(MoneyFlow data) {
    return data.moneyFlowType == 'DEPOSIT'
        ? Row(
            children: [
              Icon(
                Icons.arrow_circle_up_rounded,
                color: Colors.green,
              ),
              Text("${data.moneyFlowType!}")
            ],
          )
        : Row(
            children: [
              Icon(
                Icons.arrow_circle_down_rounded,
                color: Colors.red,
              ),
              Text("${data.moneyFlowType!}")
            ],
          );
  }

  @override
  Widget rightWidget(MoneyFlow data) {
    return Text("${data.amount}");
  }

  @override
  void onRowTap(MoneyFlow data) {
    // TODO: implement onRowTap
  }

  @override
  Widget noFoundDataWidget() {
    return Text("Nakit akışı kaydınız bulunmamaktadır.");
  }

  @override
  void onPressedCardTitleButton() {
    Navigator.push(buildContext, MaterialPageRoute(builder: (context) => MoneyFlowListPage()));
  }
}
