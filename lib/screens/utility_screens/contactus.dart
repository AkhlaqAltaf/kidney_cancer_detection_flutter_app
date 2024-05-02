import 'package:flutter/material.dart';
import 'package:kidney_cancer_detection/screens/utility_screens/background.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Contact Us'),
        ),
        body: background_body(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20.0),
                  const CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage(
                        'assets/kidney.jpg'), // Replace 'assets/company_logo.png' with your logo image path
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Your Message',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      // Handle sending message
                    },
                    child: const Text('Send'),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    'Contact Details',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'Phone: +1234567890',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  const Text(
                    'Email: info@example.com',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
