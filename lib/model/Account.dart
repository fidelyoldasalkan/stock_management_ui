import 'package:stock_management_ui/model/BaseModel.dart';

class Account extends BaseModel {
  String? name;
  int? corporationId;
  double? commissionRate;
  String? corporationName;
  double? amount;
  List<dynamic>? transactionList;
  bool? isDefault;

  Account(
      [int id = 0,
      this.name = "",
      this.corporationId = 0,
      this.commissionRate = 0.0,
      this.corporationName,
      this.amount,
      this.transactionList,
      this.isDefault = false])
      : super(id);

  Map<String, dynamic> toJson() => {
        "id": "$id",
        "name": name,
        "corporationId": "$corporationId",
        "commissionRate": "$commissionRate",
        "isDefault": isDefault
      };

  static Account fromJson(Map<String, dynamic> json) {
    return Account(
        json['id'],
        json['name'],
        json['corporationId'],
        json['commissionRate'],
        json['corporationName'],
        json['amount'],
        json['transactionList'],
        json['isDefault']);
  }
}
