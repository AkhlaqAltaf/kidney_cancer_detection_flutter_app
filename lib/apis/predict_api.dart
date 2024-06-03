import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kidney_cancer_detection/screens/utility_screens/flashMessage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';

Future<void> fetchPrediction(BuildContext context, File file,
    StreamController<double> progressStream) async {
  String url = "http://192.168.1.7:8050/upload";

  try {
    var request = http.MultipartRequest('POST', Uri.parse(url));

    var fileStream = http.ByteStream(file.openRead());
    var length = await file.length();
    var multipartFile = http.MultipartFile('file', fileStream, length,
        filename: file.path.split('/').last);
    request.files.add(multipartFile);

    int bytesSent = 0;
    fileStream.transform(StreamTransformer.fromHandlers(
      handleData: (data, sink) {
        bytesSent += data.length;
        progressStream.add(bytesSent / length);
        sink.add(data);
      },
    ));

    var response = await request.send();

    if (response.statusCode == 200) {
      var contentLength = int.parse(response.headers['content-length'] ?? '0');

      Directory? downloadDir = await getExternalStorageDirectory();
      String filePath = '${downloadDir!.path}/prediction.pdf';

      File pdfFile = File(filePath);

      var outputStream = pdfFile.openWrite();

      await response.stream.pipe(outputStream);

      await outputStream.close();

      flashMessage(context, "success", 'PDF file downloaded successfully');

      OpenFilex.open(filePath);
    } else {
      flashMessage(context, "error",
          'Failed to download PDF file. Status code: ${response.statusCode}');
    }
  } catch (error) {
    flashMessage(context, "error", 'Failed to download PDF file: $error');
  } finally {
    progressStream.close();
  }
}
