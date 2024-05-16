import 'package:flutter/material.dart';
import 'package:kidney_cancer_detection/data_layer/doctor_model.dart';
import 'package:kidney_cancer_detection/firebase/doctor_store.dart';

class DoctorProvider extends ChangeNotifier {
  // ATTRIBUTES
  String _name = '';
  String _specialist = '';
  String _lat = '';
  String _long = '';
  String _clinic = '';
  String _imageUrl = '';

  bool _navigate = false;

// GETTER METHODS

  String get name => _name;
  String get specialist => _specialist;
  String get lat => _lat;
  String get long => _long;
  String get clinic => _clinic;
  String get imageUrl => _imageUrl;
  bool get navigate => _navigate;

// SETTTER METHODS

  set name(String value) {
    this._name = value;
  }

  set specialist(String value) {
    this._specialist = value;
  }

  set lat(String value) {
    this._lat = value;
  }

  set long(String value) {
    this._long = value;
  }

  set clinic(String value) {
    this._clinic = value;
  }

  set imageUrl(String value) {
    this._imageUrl = value;
    print("LISTENED .............");
    notifyListeners();
  }

  set navigate(bool navigate_) {
    this._navigate = navigate_;
    notifyListeners();
  }

  Future register(BuildContext context) async {
    
    print("IMAGE URL ");
    print(imageUrl);
    DoctorFormData doctor =
        DoctorFormData(name, specialist, lat, long, clinic, imageUrl);
    await saveDoctorData(doctor);
  }
}
