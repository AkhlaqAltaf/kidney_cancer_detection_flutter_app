// import 'dart:io';

// import 'package:firebase_storage/firebase_storage.dart';

// final storageReference = FirebaseStorage.instance.ref();

// Future<String> uploadProfileImage(String userId, String imagePath) async {
//   final StorageUploadTask uploadTask = storageReference.child('profile_images').child(userId).putFile(File(imagePath));
//   final StorageTaskSnapshot downloadUrl = await uploadTask.onComplete;
//   final String url = await downloadUrl.ref.getDownloadURL();
//   return url;
// }
