import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kidney_cancer_detection/screens/utility_screens/flashMessage.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';

Future<void> fetchPrediction(BuildContext context, File file) async {
  String url =
      "http://192.168.1.13:5000/upload"; // Change the URL to your server endpoint

  try {
    // Create a multipart request
    var request = http.MultipartRequest('POST', Uri.parse(url));

    // Add file to the request
    var fileStream = http.ByteStream(file.openRead());
    var length = await file.length();
    var multipartFile = http.MultipartFile('file', fileStream, length,
        filename: file.path.split('/').last);
    request.files.add(multipartFile);

    // Send the request
    var response = await request.send();

    // Check the response status code
    if (response.statusCode == 200) {
      // Get the response content length
      var contentLength = int.parse(response.headers['content-length'] ?? '0');

      // Get the download directory path
      Directory? downloadDir = await getExternalStorageDirectory();
      String filePath = '${downloadDir!.path}/prediction.pdf';

      // Create a file to save the PDF
      File pdfFile = File(filePath);

      // Open a stream to write the PDF content
      var outputStream = pdfFile.openWrite();

      // Write the PDF content to the file
      await response.stream.pipe(outputStream);

      // Close the stream
      await outputStream.close();

      // Show success message
      flashMessage(context, "success", 'PDF file downloaded successfully');

      // Open the PDF file
      OpenFilex.open(filePath);
    } else {
      // Show error message
      flashMessage(context, "error",
          'Failed to download PDF file. Status code: ${response.statusCode}');
    }
  } catch (error) {
    // Show error message
    flashMessage(context, "error", 'Failed to download PDF file: $error');
  }
}
