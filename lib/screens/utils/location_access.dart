import 'package:location/location.dart';

void location() async {
  Location location = Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      // Handle the case where the user denied permission
      return;
    }
  }

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      // Handle the case where location services are disabled by the user
      return;
    }
  }

  _locationData = await location.getLocation();
  double? latitude = _locationData.latitude;
  double? longitude = _locationData.longitude;
  print("LOCATION IS HERE ..........");

  print(latitude);
  print(longitude);
}
