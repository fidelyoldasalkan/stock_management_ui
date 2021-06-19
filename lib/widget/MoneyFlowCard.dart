import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stock_management_ui/model/MoneyFlow.dart';
import 'package:stock_management_ui/util/UrlBuilder.dart';
import 'package:stock_management_ui/widget/AbstractCard.dart';

class MoneyFlowCard extends AbstractCard<MoneyFlow> {
  MoneyFlowCard() : super('Nakit Akışı', UrlBuilder.build("money-flow/list"));

  @override
  MoneyFlow mapper(json) {
    return MoneyFlow(json['id'], json['accountId'],
        json['moneyFlowType'], json['amount'], json['date']);
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
}
