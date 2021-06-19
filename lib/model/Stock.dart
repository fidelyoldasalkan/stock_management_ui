import 'package:stock_management_ui/model/BaseModel.dart';

class Stock extends BaseModel {

  String? shortCode;
  String? name;

  static Stock fromJson(json) {
    Stock s = Stock();
    s.id = json['id'];
    s.shortCode = json['shortCode'];
    s.name = json['name'];
    return s;
  }


}