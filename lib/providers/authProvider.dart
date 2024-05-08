import 'package:flutter/material.dart';
import 'package:kidney_cancer_detection/firebase/firebase_auth.dart';

class AuthentcationProvider extends ChangeNotifier {
  // CREADENTIALS
  String _email = "";
  String _password = "";

  // MESSAGE REQUIRED ATTRIBUTES

  Map<dynamic, String> _message = {};
  bool _navigate = false;

  String get email => _email;
  String get password => _password;
  Map<dynamic, String> get message => _message;
  bool get navigate => _navigate;

  set email(String email_) {
    this._email = email_;
  }

  set password(String password_) {
    this._password = password_;
  }

  set message(Map<dynamic, String> message_) {
    this._message = message_;
  }

  set navigate(bool navigate_) {
    this._navigate = navigate_;
    notifyListeners();
  }

  Future register(BuildContext context) async {
    await FirebaseAuthentication.registerUser(context, _email, _password);
  }

  Future signIn(BuildContext context) async {
    await FirebaseAuthentication.signInUser(context, _email, _password);
  }
}
