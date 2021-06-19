import 'package:stock_management_ui/model/BaseModel.dart';

class Exchange extends BaseModel {
  int? accountId;
  String? stock;
  int? lot;
  double? price;
  String? date;
  double? commission;

  Exchange([int id= 0, this.accountId, this.stock, this.lot,
      this.price, this.date, this.commission])
      : super(id);

  static Exchange fromJson(Map<String, dynamic> json) {
    return Exchange(
      json['id'],
      json['accountId'],
      json['stock'],
      json['lot'],
      json['price'],
      json['date'],
      json['commission'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": "$id",
      "accountId": "$accountId",
      "date": date,
      "stock": stock,
      "lot": lot,
      "price": price,
      "commission": commission
    };
  }
}
