import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:kidney_cancer_detection/apis/predict_api.dart';

class PredictKidneyCancer extends StatefulWidget {
  @override
  _PredictKidneyCancerState createState() => _PredictKidneyCancerState();
}

class _PredictKidneyCancerState extends State<PredictKidneyCancer> {
  File? _file;
  List<dynamic>? _output;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
  }

  ////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predict Kidney Cancer'),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : _file == null
              ? Center(child: Text('No file selected'))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Depending on the type of file, you can display it differently
                    if (_file!.path.endsWith('.jpg') ||
                        _file!.path.endsWith('.jpeg') ||
                        _file!.path.endsWith('.png'))
                      Image.file(_file!)
                    else
                      Text('Selected file: ${_file!.path}'),
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
        onPressed: getFile,
        tooltip: 'Select File',
        child: Icon(Icons.file_upload),
      ),
    );
  }

  bool _inferenceInProgress = false;

  Future<void> getFile() async {
    if (_inferenceInProgress) return;
    _inferenceInProgress = true;

    final FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _file = File(result.files.single.path!);
      });
      await fetchPrediction(context, _file!);
    }

    _inferenceInProgress = false;
  }
}
