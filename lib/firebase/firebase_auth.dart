import 'package:firebase_auth/firebase_auth.dart';
import 'package:kidney_cancer_detection/firebase/firebase_initialized.dart';

class FirebaseAuthentication {


  // CHECK AUTHERIZATION 


  Future<bool> isAutherized() async {
    FirebaseAuth auth = FirebaseInstances.firebaseAuthInstance();
    bool isAuth = false;
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        isAuth =  false;
      } else {
        print('User is signed in!');
        isAuth =  true;
      }
    });
    return isAuth;
  }


  // CREATE USER

  void createUser() async{

  

  try {
  UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: "barry.allen@example.com",
    password: "SuperSecretPassword!"
  );
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
  }
} catch (e) {
  print(e);
}
}



}
