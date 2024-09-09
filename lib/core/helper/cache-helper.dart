import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences prefs;

  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<bool?> setUserToken(String value) async {
    try {
      await prefs.setString('token', value);
      return true; // Indicate success
    } catch (e) {
      print('Error setting token: $e');
      return false; // Indicate failure
    }
  }

  static String getUserToken() {
    return prefs.getString('token') ?? '';
  }

  static Future<bool> setLang(value) async {
    return prefs.setString('lang', value);
  }

  static String getLang() {
    return prefs.getString('lang') ?? '';
  }

  static Future<bool> setUid(value) async {
    return prefs.setBool('uid', value);
  }

  static Future<bool?> getUid() async {
    return prefs.getBool('uid');
  }

  static Future<bool?> getBoardingMode() async {
    return prefs.getBool('boarding');
  }

  static Future<bool> setBoardingMode(value) async {
    return prefs.setBool('boarding', value);
  }
  
}
