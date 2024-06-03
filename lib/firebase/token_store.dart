import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences package

void storeToken(String token) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString("token", token);
}

Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? token = pref.getString("token");
  return token!;
}

Future<void> clearData() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}
