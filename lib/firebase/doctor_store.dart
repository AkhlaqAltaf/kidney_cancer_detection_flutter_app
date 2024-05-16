import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kidney_cancer_detection/data_layer/doctor_model.dart';
import 'package:kidney_cancer_detection/screens/utility_screens/flashMessage.dart';

Future<void> saveDoctorData(DoctorFormData formData) async {
  final db = FirebaseFirestore.instance;
  final docRef = db.collection('doctors').doc();
  await docRef.set(formData.toMap());
}

Future<List<DoctorFormData>> getDoctorData(BuildContext context) async {
  try {
    final db = FirebaseFirestore.instance;
    final querySnapshot = await db.collection('doctors').get();

    List<DoctorFormData> doctorList = [];

    querySnapshot.docs.forEach((doc) {
      doctorList.add(DoctorFormData.fromMap(doc.data()));
    });

    return doctorList;
  } catch (e) {
    print('Error fetching doctor data: $e');
    flashMessage(context, "error", "ERRR  ${e.toString()}");

    throw Exception('Failed to fetch doctor data');
  }
}
