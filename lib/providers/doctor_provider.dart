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
  String _contactNumber = "";
  String _completeAddress = "";

  bool _navigate = false;

// GETTER METHODS

  String get name => _name;
  String get specialist => _specialist;
  String get lat => _lat;
  String get long => _long;
  String get clinic => _clinic;
  String get imageUrl => _imageUrl;
  String get contactNumber => _contactNumber;
  String get completeAddress => _completeAddress;

  bool get navigate => _navigate;

  set contactNumber(String contactNumber_) {
    this._contactNumber = contactNumber_;
  }

  set completeAddress(String completeAddress_) {
    this._completeAddress = completeAddress_;
  }

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
    DoctorFormData doctor = DoctorFormData(_name, _specialist, _lat, _long,
        _clinic, _imageUrl, _contactNumber, _completeAddress);
    await saveDoctorData(doctor);
  }
}
