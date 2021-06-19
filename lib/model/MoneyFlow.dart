import 'package:stock_management_ui/model/BaseModel.dart';

class MoneyFlow extends BaseModel {
  int? accountId;
  String? moneyFlowType;
  double? amount;
  String? date;
  String? accountName;


  MoneyFlow([int id = 0, this.accountId, this.moneyFlowType,
      this.amount, this.date, this.accountName])
      : super(id);

  static MoneyFlow fromJson(Map<String, dynamic> json) {
    return MoneyFlow(json['id'], json['accountId'],
        json['moneyFlowType'], json['amount'], json['date'], json['accountName']);
  }

  Map<String, dynamic> toJson() =>
      {
        "id": "$id",
        "accountId": "$accountId",
        "moneyFlowType": "$moneyFlowType",
        "amount": "$amount",
        "date": date
      };
}
