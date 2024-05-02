import 'package:flutter/material.dart';
import 'package:kidney_cancer_detection/screens/utility_screens/background.dart';

class Doctor {
  final String name;
  final String specialist;
  final String address;
  final String clinicName;
  final String avatarUrl;

  Doctor({
    required this.name,
    required this.specialist,
    required this.address,
    required this.clinicName,
    required this.avatarUrl,
  });
}

class DoctorListPage extends StatelessWidget {
  final List<Doctor> doctors = [
    Doctor(
      name: 'Dr. John Doe',
      specialist: 'Cardiologist',
      address: '123 Main St, City',
      clinicName: 'Heart Care Clinic',
      avatarUrl: 'assets/doctors/doctors.jpg',
    ),
    Doctor(
      name: 'Dr. Jane Smith',
      specialist: 'Pediatrician',
      address: '456 Oak Ave, Town',
      clinicName: 'Kids Health Center',
      avatarUrl: 'assets/doctors/doctors.jpg',
    ),
    Doctor(
      name: 'Dr. John Doe',
      specialist: 'Cardiologist',
      address: '123 Main St, City',
      clinicName: 'Heart Care Clinic',
      avatarUrl: 'assets/doctors/doctors.jpg',
    ),
    Doctor(
      name: 'Dr. Jane Smith',
      specialist: 'Pediatrician',
      address: '456 Oak Ave, Town',
      clinicName: 'Kids Health Center',
      avatarUrl: 'assets/doctors/doctors.jpg',
    ),
    Doctor(
      name: 'Dr. John Doe',
      specialist: 'Cardiologist',
      address: '123 Main St, City',
      clinicName: 'Heart Care Clinic',
      avatarUrl: 'assets/doctors/doctors.jpg',
    ),
    Doctor(
      name: 'Dr. Jane Smith',
      specialist: 'Pediatrician',
      address: '456 Oak Ave, Town',
      clinicName: 'Kids Health Center',
      avatarUrl: 'assets/doctors/doctors.jpg',
    ),
    Doctor(
      name: 'Dr. John Doe',
      specialist: 'Cardiologist',
      address: '123 Main St, City',
      clinicName: 'Heart Care Clinic',
      avatarUrl: 'assets/doctors/doctors.jpg',
    ),
    Doctor(
      name: 'Dr. Jane Smith',
      specialist: 'Pediatrician',
      address: '456 Oak Ave, Town',
      clinicName: 'Kids Health Center',
      avatarUrl: 'assets/doctors/doctors.jpg',
    ),
    Doctor(
      name: 'Dr. John Doe',
      specialist: 'Cardiologist',
      address: '123 Main St, City',
      clinicName: 'Heart Care Clinic',
      avatarUrl: 'assets/doctors/doctors.jpg',
    ),
    Doctor(
      name: 'Dr. Jane Smith',
      specialist: 'Pediatrician',
      address: '456 Oak Ave, Town',
      clinicName: 'Kids Health Center',
      avatarUrl: 'assets/doctors/doctors.jpg',
    ),
    // Add more doctors as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Doctors'),
        ),
        body: background_body(
          child: ListView.builder(
            itemCount: doctors.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(doctors[index].avatarUrl),
                  ),
                  title: Text(doctors[index].name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Specialist: ${doctors[index].specialist}'),
                      Text('Address: ${doctors[index].address}'),
                      Text('Clinic: ${doctors[index].clinicName}'),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
