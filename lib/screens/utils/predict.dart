import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:kidney_cancer_detection/apis/predict_api.dart';

class PredictKidneyCancer extends StatefulWidget {
  @override
  _PredictKidneyCancerState createState() => _PredictKidneyCancerState();
}

class _PredictKidneyCancerState extends State<PredictKidneyCancer> {
  File? _file;
  List<dynamic>? _output;
  bool _loading = false;
  StreamController<double>? _progressStream;
  bool _inferenceInProgress = false;

  @override
  void initState() {
    super.initState();
    _progressStream = StreamController<double>();
  }

  @override
  void dispose() {
    _progressStream?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predict Kidney Cancer'),
      ),
      body: Column(
        children: [
          if (_inferenceInProgress)
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.amber,
              child: Text(
                'Please wait, awaiting server response...',
                style: TextStyle(color: Colors.black),
              ),
            ),
          Expanded(
            child: _loading
                ? Center(
                    child: StreamBuilder<double>(
                      stream: _progressStream!.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(value: snapshot.data),
                              SizedBox(height: 20),
                              Text(
                                  '${(snapshot.data! * 100).toStringAsFixed(2)}% uploaded'),
                            ],
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  )
                : _file == null
                    ? Center(child: Text('No file selected'))
                    : SingleChildScrollView(
                        child: Column(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Predictions:',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      SizedBox(height: 10),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
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
                      ),
          ),
        ],
      ),
      floatingActionButton: _inferenceInProgress
          ? null
          : FloatingActionButton(
              onPressed: getFile,
              tooltip: 'Select File',
              child: Icon(Icons.file_upload),
            ),
    );
  }

  Future<void> getFile() async {
    if (_inferenceInProgress) return;
    _inferenceInProgress = true;

    final FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _file = File(result.files.single.path!);
        _loading = true;
      });

      // Reset the progress stream controller for new upload
      _progressStream = StreamController<double>();

      await fetchPrediction(context, _file!, _progressStream!);

      setState(() {
        _loading = false;
        _inferenceInProgress = false;
      });

      // Dispose of the old stream and create a new one for future uploads
      _progressStream!.close();
      _progressStream = StreamController<double>();
    } else {
      _inferenceInProgress = false;
    }
  }
}
