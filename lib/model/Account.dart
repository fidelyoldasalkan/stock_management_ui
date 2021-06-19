import 'package:stock_management_ui/model/BaseModel.dart';

import 'MoneyFlow.dart';

class Account extends BaseModel {

  String? name;
  int? corporationId;
  double? commissionRate;
  String? corporationName;
  double? amount;
  List<MoneyFlow>? moneyFlowList;

  Account(
      [int id = 0, this.name = "", this.corporationId = 0, this.commissionRate = 0.0, this.corporationName, this.amount, this.moneyFlowList])
      : super(id);

  Map<String, dynamic> toJson() =>
      {
        "id": "$id",
        "name": name,
        "corporationId": "$corporationId",
        "commissionRate": "$commissionRate"
      };

  static Account fromJson(Map<String, dynamic> json) {
    return Account(json['id'], json['name'], json['corporationId'],
        json['commissionRate'], json['corporationName'], json['amount'], json['moneyFlowList']);
  }

}