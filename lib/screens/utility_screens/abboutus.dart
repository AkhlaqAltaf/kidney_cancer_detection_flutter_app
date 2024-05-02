import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage(
                    'assets/kidney.jpg'), // Replace 'assets/company_logo.png' with your logo image path
              ),
              SizedBox(height: 20.0),
              Text(
                'Our Company',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed commodo, velit id rhoncus volutpat, velit odio consequat ligula, eu aliquam dui ligula a nunc. Cras condimentum, orci nec sodales pulvinar, elit metus fermentum libero, ut rhoncus orci turpis at nisl. Proin ultricies suscipit libero, vel vehicula neque fermentum vel. Vivamus commodo turpis vel est facilisis condimentum.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Address: 123 Main St, City, Country',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                'Phone: +1234567890',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                'Email: info@example.com',
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
