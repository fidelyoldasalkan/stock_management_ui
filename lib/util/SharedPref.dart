import 'package:shared_preferences/shared_preferences.dart';

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
}