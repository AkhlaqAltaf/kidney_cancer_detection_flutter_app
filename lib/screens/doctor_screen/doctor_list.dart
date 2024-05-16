import 'package:flutter/material.dart';
import 'package:kidney_cancer_detection/data_layer/doctor_model.dart';
import 'package:kidney_cancer_detection/firebase/doctor_store.dart';
import 'package:kidney_cancer_detection/screens/doctor_screen/doctor_form.dart';
import 'package:kidney_cancer_detection/screens/utility_screens/background.dart';

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
      body: background_body(
        child: FutureBuilder<List<DoctorFormData>>(
          future: getDoctorData(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(snapshot.data![index].imageUrl),
                      ),
                      title: Text(snapshot.data![index].name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Specialist: ${snapshot.data![index].specialist}'),
                          Text(
                              'Address: ${snapshot.data![index].lat} , ${snapshot.data![index].long}'),
                          Text('Clinic: ${snapshot.data![index].clinic}'),
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
        ),
      ),
    );
  }
}
