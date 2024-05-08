import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:tflite_flutter/tflite_flutter.dart';

class PredictKidneyCancer extends StatefulWidget {
  @override
  _PredictKidneyCancerState createState() => _PredictKidneyCancerState();
}

class _PredictKidneyCancerState extends State<PredictKidneyCancer> {
  File? _image;
  List<dynamic>? _output;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;
    loadModel().then((value) {
      print("MODEL LOADED SUCCESS FULLY ");
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  Future<void> loadModel() async {
    try {
      String? res = await Tflite.loadModel(
        model: 'assets/model/model.tflite',
        labels: 'assets/model/dict.txt',
      );
      print(res);
    } on Exception catch (e) {
      print('Failed to load model: $e');
    }
  }

  bool _inferenceInProgress = false;

  Future<void> getImage() async {
    if (_inferenceInProgress)
      return; // Return if inference is already in progress
    _inferenceInProgress = true; // Set flag to indicate inference in progress

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    print("IMAGE FILE IS HERE : ::::::::  $pickedFile");
    setState(() {
      _image = File(pickedFile!.path);
    });
    await runModelOnImage();
    _inferenceInProgress = false;
  }

  Future<void> runModelOnImage() async {
    if (_image == null) return;
    setState(() {
      _loading = true;
    });

    try {
      var output = await Tflite.runModelOnImage(
        path: _image!.path,
        numResults: 3,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5,
      );
      setState(() {
        _loading = false;
        _output = output;
      });
    } on Exception catch (e) {
      print('Failed to run model on image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predict Kidney Cancer'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _image == null
              ? const Center(child: Text('No image selected'))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.file(_image!),
                    const SizedBox(height: 20),
                    _output != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Predictions:',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 10),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: _output!.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                      _output![index]['label'],
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    subtitle: Text(
                                      'Confidence: ${(_output![index]['confidence'] * 100).toStringAsFixed(2)}%',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  );
                                },
                              ),
                            ],
                          )
                        : SizedBox(),
                  ],
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Select Image',
        child: Icon(Icons.image),
      ),
    );
  }
}
