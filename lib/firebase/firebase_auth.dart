import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kidney_cancer_detection/firebase/token_store.dart';
import 'package:kidney_cancer_detection/providers/authProvider.dart';
import 'package:kidney_cancer_detection/screens/utility_screens/flashMessage.dart';
import 'package:provider/provider.dart';

class FirebaseAuthentication {
  // CHECK AUTHERIZATION
  static Future<bool> isAutherized() async {
    String user = await getToken();
    return user != null;
  }

  // CREATE USER
  static Future registerUser(
      BuildContext context, String email, String password) async {
    AuthentcationProvider provider =
        Provider.of<AuthentcationProvider>(context, listen: false);

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      String? token = await userCredential.user!.getIdToken();
      storeToken(token!);
      provider.navigate = true;

      flashMessage(context, "success", "USER CREATED SUCCESSFULLY");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        flashMessage(context, "error", 'The password provided is too weak.');
        provider.navigate = false;
      } else if (e.code == 'email-already-in-use') {
        flashMessage(
            context, "error", 'The account already exists for that email.');
        provider.navigate = false;
      }
    } catch (e) {
      print(e);
      flashMessage(context, "error", e.toString());
      provider.navigate = false;
    }
  }

  static Future signInUser(
      BuildContext context, String email, String password) async {
    AuthentcationProvider provider =
        Provider.of<AuthentcationProvider>(context, listen: false);
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      String? token = await userCredential.user!.getIdToken();
      storeToken(token!);
      flashMessage(context, "success", "USER SIGNIN SUCCESSFULLY");
      provider.navigate = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        provider.navigate = false;

        flashMessage(context, "error", "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        flashMessage(
            context, "error", 'Wrong password provided for that user.');
        provider.navigate = false;
      } else {
        flashMessage(context, "error", e.toString());
        provider.navigate = false;
      }
    }
  }
}
