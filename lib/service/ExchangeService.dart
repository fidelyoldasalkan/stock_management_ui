import 'package:stock_management_ui/util/HttpUtil.dart';
import 'package:stock_management_ui/util/UrlBuilder.dart';

class ExchangeService {

  static Future<dynamic> delete(int id) async {
    await HttpUtil.delete(UrlBuilder.exchangeDelete(id), () { }, () { });
  }

}