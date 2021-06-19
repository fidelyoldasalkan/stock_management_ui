import 'package:stock_management_ui/model/BaseModel.dart';

class Corporation extends BaseModel {
  String? name;
  String? imageUrl;

  Corporation([int id = 0, this.name = "", this.imageUrl = ""]) : super(id);

  @override
  int get hashCode => super.hashCode;

  static Corporation fromJson(dynamic json) {
    return Corporation(json['id'], json['name'], json['imageUrl']);
  }
}
