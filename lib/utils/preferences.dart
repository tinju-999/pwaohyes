import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static Future setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userToken", token);
  }

  static setRefreshToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("refreshToken", token);
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
    prefs.setString("verifiedData", verifiedData);
  }

  static clearAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static setLocation(String location) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("location", location);
  }

  static Future<String> getLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("location") ?? "";
  }

  static setPhone(String phone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("phone", phone);
  }

  static Future<String> getPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("phone") ?? "";
  }
}
