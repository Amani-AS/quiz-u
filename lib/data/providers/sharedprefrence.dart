import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data_constants.dart';

class SharedPreferenceProvider with ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  setToken(jtw) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString(AppConstants.keyAccessToken, jtw);
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString(AppConstants.keyAccessToken)!;
    return token;
  }
}
