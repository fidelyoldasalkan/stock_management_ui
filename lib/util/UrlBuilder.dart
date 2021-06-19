class UrlBuilder {
  static String _baseUrl = "http://192.168.1.107:8080/";

  static String build(String endPoint) {
    return _baseUrl + endPoint;
  }

  static Uri corporationList() {
    return Uri.parse(build("corporation/list"));
  }

  static Uri accountSave() {
    return Uri.parse(build("account/save"));
  }

  static Uri login() {
    return Uri.parse(build("auth/login"));
  }

  static Uri accountList() {
    return Uri.parse(build("account/list"));
  }

  static Uri accountDelete(int id) {
    return Uri.parse(build("account/delete/$id"));
  }

  static Uri moneyFlowList() {
    return Uri.parse(build("money-flow/list"));
  }

  static Uri saveMoneyFlow() {
    return Uri.parse(build("money-flow/save"));
  }

  static Uri dividendList() {
    return Uri.parse(build("dividend/list"));
  }

  static Uri stockList() {
    return Uri.parse(build("stock/listAll"));
  }

  static Uri dividendSave() {
    return Uri.parse(build("dividend/save"));
  }

  static Uri dividendDelete(int id) {
    return Uri.parse(build("dividend/$id"));
  }

  static Uri moneyFlowDelete(int id) {
    return Uri.parse(build("money-flow/delete/$id"));
  }

  static Uri exchangeList() {
    return Uri.parse(build("exchange/list"));
  }

  static Uri exchangeDelete(int id) {
    return Uri.parse(build("exchange/delete/$id"));
  }

  static exchangeSave() {
    return Uri.parse(build("exchange/save"));
  }
}
