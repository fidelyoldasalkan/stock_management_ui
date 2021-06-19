import 'package:stock_management_ui/model/BaseModel.dart';

class Dividend extends BaseModel {
  int? accountId;
  String? date;
  String? stock;
  int? lot;
  double? amount;

  Dividend([int id = 0, this.accountId, this.date, this.stock, this.lot, this.amount])
      : super(id);

  static Dividend fromJson(Map<String, dynamic> json) {
    return Dividend(json['id'], json['accountId'], json['date'], json['stock'],
        json['lot'], json['amount']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": "$id",
      "accountId": "$accountId",
      "date": date,
      "stock": stock,
      "lot": lot,
      "amount": amount,
    };
  }
}
