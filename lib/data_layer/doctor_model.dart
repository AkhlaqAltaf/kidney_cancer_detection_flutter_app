import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:kidney_cancer_detection/screens/utility_screens/flashMessage.dart';

class DoctorFormData {
  final String name;
  final String specialist;
  final String lat;
  final String long;
  final String clinic;
  final String imageUrl;

  const DoctorFormData(this.name, this.specialist, this.lat, this.long,
      this.clinic, this.imageUrl);

  Map<String, dynamic> toMap() {
    return {
      'username': name,
      'specialist': specialist,
      'lat': lat,
      'long': long,
      'clinic': clinic,
      'imageUrl': imageUrl,
    };
  }

  static Future<String> uploadImage(
      BuildContext context, String imagePath) async {
    try {
      final firebaseStorage = FirebaseStorage.instance;
      final ref = firebaseStorage
          .ref()
          .child('doctor_images/${DateTime.now().millisecondsSinceEpoch}');
      final uploadTask = ref.putFile(File(imagePath));

      final snapshot = await uploadTask.whenComplete(() => null);

      final url = await snapshot.ref.getDownloadURL();
      flashMessage(context, 'success', "${url}");

      return url;
    } catch (e) {
      flashMessage(context, 'error', "IMAGE NOT UPLOADED");
      print('Error uploading image: $e');
      return '';
    }
  }

  factory DoctorFormData.fromMap(Map<String, dynamic> map) {
    return DoctorFormData(
      map['username'] ?? '',
      map['specialist'] ?? '',
      map['lat'] ?? '',
      map['long'] ?? '',
      map['clinic'] ?? '',
      map['imageUrl'] ?? '',
    );
  }
}
