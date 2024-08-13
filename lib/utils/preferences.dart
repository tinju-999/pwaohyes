import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static Future<bool> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("userToken", token);
  }

  static setRefreshToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("refreshToken", token);
  }

  static Future<String> getRefershToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("refreshToken") ?? "";
  }

  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("userToken") ?? "";
  }

  static setVerifiedData(String verifiedData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("verifiedData", verifiedData);
  }

  static clearAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
