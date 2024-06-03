import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kidney_cancer_detection/data_layer/doctor_model.dart';
import 'package:kidney_cancer_detection/providers/doctor_provider.dart';
import 'package:kidney_cancer_detection/screens/utility_screens/home.dart';
import 'package:provider/provider.dart';

class DoctorForm extends StatefulWidget {
  DoctorForm({Key? key}) : super(key: key);

  @override
  _DoctorFormState createState() => _DoctorFormState();
}

class _DoctorFormState extends State<DoctorForm> {
  late String _imageUrl;
  File? _image;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _imageUrl = '';
  }

  bool _inferenceInProgress = false;

  Future<void> getImage() async {
    if (_inferenceInProgress)
      return; // Return if inference is already in progress
    _inferenceInProgress = true; // Set flag to indicate inference in progress

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile!.path);
      _imageUrl = _image!.path;
    });
    _inferenceInProgress = false;
  }

  @override
  Widget build(BuildContext context) {
    DoctorProvider provider = Provider.of<DoctorProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xffB81736),
                  Color(0xff281537),
                ],
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 60.0, left: 22),
              child: Text(
                'Create Doctor\nAccount',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, right: 18, bottom: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        TextFormField(
                          onChanged: (value) {
                            provider.name = value;
                          },
                          decoration: const InputDecoration(
                            suffixIcon: Icon(
                              Icons.check,
                              color: Colors.grey,
                            ),
                            labelText: 'Name',
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffB81736),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a name';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          onChanged: (value) {
                            provider.specialist = value;
                          },
                          decoration: const InputDecoration(
                              suffixIcon: Icon(
                                Icons.type_specimen,
                                color: Colors.grey,
                              ),
                              label: Text(
                                'Specialization',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffB81736),
                                ),
                              )),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a specialization';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          onChanged: (value) {
                            provider.clinic = value;
                          },
                          decoration: const InputDecoration(
                              suffixIcon: Icon(
                                Icons.local_hospital_outlined,
                                color: Colors.grey,
                              ),
                              label: Text(
                                'Clinic Name',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffB81736),
                                ),
                              )),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a clinic name';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          onChanged: (value) {
                            provider.lat = value;
                          },
                          decoration: const InputDecoration(
                              suffixIcon: Icon(
                                Icons.place,
                                color: Colors.grey,
                              ),
                              label: Text(
                                'Lat (Latitude)',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffB81736),
                                ),
                              )),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a latitude';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Please enter a valid number';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          onChanged: (value) {
                            provider.long = value;
                          },
                          decoration: const InputDecoration(
                              suffixIcon: Icon(
                                Icons.place,
                                color: Colors.grey,
                              ),
                              label: Text(
                                'Long (Longitude)',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffB81736),
                                ),
                              )),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a longitude';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Please enter a valid number';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          onChanged: (value) {
                            provider.completeAddress = value;
                          },
                          decoration: const InputDecoration(
                              suffixIcon: Icon(
                                Icons.home,
                                color: Colors.grey,
                              ),
                              label: Text(
                                'Complete Address',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffB81736),
                                ),
                              )),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a complete address';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          onChanged: (value) {
                            provider.contactNumber = value;
                          },
                          decoration: const InputDecoration(
                              suffixIcon: Icon(
                                Icons.phone,
                                color: Colors.grey,
                              ),
                              label: Text(
                                'Contact Number',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffB81736),
                                ),
                              )),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a contact number';
                            }
                            return null;
                          },
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            getImage();
                          },
                          child: const Text('Choose Image'),
                        ),
                        Text(
                          _imageUrl.isEmpty
                              ? 'No image selected'
                              : 'Image: $_imageUrl',
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: 70),
                        GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              String url = await DoctorFormData.uploadImage(
                                  context, _imageUrl);
                              provider.imageUrl = url;

                              if (url.isNotEmpty) {
                                await provider.register(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Home(),
                                    ));
                              }
                            }
                          },
                          child: Container(
                            height: 55,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xffB81736),
                                  Color(0xff281537),
                                ],
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
