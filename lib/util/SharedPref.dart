import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_management_ui/model/Account.dart';

class SharedPref {

  SharedPreferences? _sharedPreferences;

  SharedPref._() {
    init();
  }

  SharedPref() {
    init();
  }

  static SharedPref getInstance() {
    return SharedPref._();
  }

  init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  saveLoginInfo(String username, String password, String token) async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
    _sharedPreferences!.setString("username", username);
    _sharedPreferences!.setString("password", password);
    _sharedPreferences!.setString("token", token);
  }

  Future<String?> loadToken() async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
    return _sharedPreferences!.getString("token");
  }

  Future<String?> loadUsername() async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
    return _sharedPreferences!.getString("username");
  }

  Future<String?> loadPassword() async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
    return _sharedPreferences!.getString("password");
  }

  void saveDefaultAccount(Account account) async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
    _sharedPreferences!.setString("defaultAccountName", account.name!);
    _sharedPreferences!.setInt("defaultAccountId", account.id!);
    _sharedPreferences!.setDouble("defaultAccountCommission", account.commissionRate!);
  }

  Future<String?> loadDefaultAccountName() async{
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
    return _sharedPreferences!.getString("defaultAccountName");
  }

  Future<int?> loadDefaultAccountId() async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
    return _sharedPreferences!.getInt("defaultAccountId");
  }

  Future<double?> loadDefaultCommission() async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
    return _sharedPreferences!.getDouble("defaultAccountCommission");
  }
}