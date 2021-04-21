import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance = new UserPreferences._internal();

  // final String _genderString = 'gender';
  // final String _secondaryColorString = 'secondary color';
  final String _tokenString = 'token';
  // final String _lastPageString = 'last page';

  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // int get gender {
  //   return _prefs.getInt(_genderString) ?? 1;
  // }

  // set gender(int value) {
  //   _prefs.setInt(_genderString, value);
  // }

  // bool get secondaryColor {
  //   return _prefs.getBool(_secondaryColorString) ?? false;
  // }

  // set secondaryColor(bool value) {
  //   _prefs.setBool(_secondaryColorString, value);
  // }

  String get token {
    return _prefs.getString(_tokenString) ?? '';
  }

  set token(String value) {
    _prefs.setString(_tokenString, value);
  }

  // String get lastPage {
  //   return _prefs.getString(_lastPageString) ?? 'login';
  // }

  // set lastPage(String value) {
  //   _prefs.setString(_lastPageString, value);
  // }
}
