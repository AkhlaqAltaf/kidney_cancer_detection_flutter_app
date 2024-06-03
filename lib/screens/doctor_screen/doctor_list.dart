import 'package:flutter/material.dart';
import 'package:kidney_cancer_detection/data_layer/doctor_model.dart';
import 'package:kidney_cancer_detection/firebase/doctor_store.dart';
import 'package:kidney_cancer_detection/screens/doctor_screen/doctor_form.dart';
import 'package:kidney_cancer_detection/screens/utils/location_access.dart';
import 'package:location/location.dart';

class DoctorListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DoctorForm(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Doctors'),
      ),
      body: FutureBuilder<LocationData>(
        future: getCurrentLocation(),
        builder: (context, locationSnapshot) {
          if (locationSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (locationSnapshot.hasError) {
            return Center(child: Text('Error: ${locationSnapshot.error}'));
          } else if (locationSnapshot.hasData) {
            LocationData userLocation = locationSnapshot.data!;
            return FutureBuilder<List<DoctorFormData>>(
              future: getDoctorData(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  List<DoctorFormData> doctors = snapshot.data!;
                  doctors.sort((a, b) {
                    double distanceA = calculateDistance(
                        userLocation.latitude!,
                        userLocation.longitude!,
                        double.parse(a.lat),
                        double.parse(a.long));
                    double distanceB = calculateDistance(
                        userLocation.latitude!,
                        userLocation.longitude!,
                        double.parse(b.lat),
                        double.parse(b.long));
                    return distanceA.compareTo(distanceB);
                  });

                  return ListView.builder(
                    itemCount: doctors.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(doctors[index].imageUrl),
                          ),
                          title: Text(doctors[index].name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Specialist: ${doctors[index].specialist}'),
                              Text(
                                  'Address: ${doctors[index].lat} , ${doctors[index].long}'),
                              Text('Clinic: ${doctors[index].clinic}'),
                              Text('Contact: ${doctors[index].contactNumber}'),
                              Text(
                                  'Complete Address: ${doctors[index].completeAddress}'),
                              if (index < 1)
                                Text(
                                  'Nearest to you',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text('No data available'));
                }
              },
            );
          } else {
            return Center(child: Text('Failed to get location'));
          }
        },
      ),
    );
  }
}
