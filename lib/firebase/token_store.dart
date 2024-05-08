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
