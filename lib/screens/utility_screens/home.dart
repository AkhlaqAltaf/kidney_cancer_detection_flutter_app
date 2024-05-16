import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button_bar.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/position/gf_position.dart';
import 'package:kidney_cancer_detection/apis/predict_api.dart';
import 'package:kidney_cancer_detection/screens/doctor_screen/doctor_list.dart';
import 'package:kidney_cancer_detection/screens/utility_screens/abboutus.dart';
import 'package:kidney_cancer_detection/screens/utility_screens/background.dart';
import 'package:kidney_cancer_detection/screens/utility_screens/contactus.dart';
import 'package:kidney_cancer_detection/screens/utils/predict.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: HomePageSources.drawer(context),
        body: background_body(
            child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) =>
              HomePageSources.bodyContainer(context),
        )));
  }
}

class HomePageSources {
  static Widget drawer(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.8,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color.fromRGBO(112, 22, 54, 35)),
            curve: Curves.easeIn,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 10),
                    Text(
                      'Detect',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Kidney Cancer',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, size: 24),
            title: const Text(
              'Home',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.health_and_safety_outlined,
              size: 24,
            ),
            title: const Text(
              'Analyse',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            onTap: () async {},
          ),
          ListTile(
            leading: const Icon(Icons.person_2_outlined, size: 24),
            title: const Text(
              'Profile',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const RotationTransition(
              turns: AlwaysStoppedAnimation(180 / 360),
              child: Icon(
                Icons.logout,
                color: Colors.red,
                size: 24,
              ),
            ),
            title: const Text(
              'Logout',
              style: TextStyle(
                fontSize: 16,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Are you sure?'),
                    content: const Text('Would you like to logout?'),
                    actions: [
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Logout'),
                        onPressed: () {},
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  static Widget bodyContainer(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.health_and_safety,
            size: 100,
          ),
          const SizedBox(
              height: 20), // Adjust spacing between the icon and the text
          Container(
            width: MediaQuery.of(context).size.width / 1.08,
            decoration: const BoxDecoration(),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Kidney Cancer Clinic",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(
                      height: 5), // Adjust the height as per your requirement
                  const SizedBox(height: 5),

                  const Text(
                    "We Do For You",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),

                  cards(context, 1, "assets/kidneycancer/scan.jpg", "Scan",
                      Icons.scanner_sharp, PredictKidneyCancer()),
                  cards(context, 1, "assets/kidneycancer/doctor.jpg",
                      "Find Doctor", Icons.medical_services, DoctorListPage()),
                  Row(children: [
                    cards(context, 2, "assets/kidneycancer/about.jpg",
                        'About Us', Icons.album_outlined, AboutUsPage()),
                    cards(context, 2, "assets/kidneycancer/contact.jpg",
                        "Contact Us", Icons.contact_page, ContactUsPage())
                  ]),

                  Container(
                    width: MediaQuery.of(context).size.width / 1.3,
                    decoration: BoxDecoration(),
                    child: const Text(
                        "Welcome to the Kidney Cancer Prediction App! Your trusted companion in health. This app utilizes advanced algorithms to assess the likelihood of kidney cancer based on provided data. Input your information, and let our app provide insights for early detection and prevention. Remember, your health is our priority. Start your journey towards proactive well-being today!"),
                  )
                ]),
          ),
        ],
      ),
    );
  }

  static Widget cards(
      BuildContext context, number, img, content, IconData icon, screen) {
    num width() {
      if (number == 1) {
        return 1;
      } else {
        return 2.2;
      }
    }

    return InkWell(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => screen,
            )),
        child: SizedBox(
            width: MediaQuery.of(context).size.width / width(),
            child: GFCard(
              height: MediaQuery.of(context).size.height / 3,
              boxFit: BoxFit.cover,
              titlePosition: GFPosition.start,
              showOverlayImage: true,
              imageOverlay: AssetImage(img),
              title: const GFListTile(
                  // avatar: GFAvatar(),

                  ),
              buttonBar: GFButtonBar(
                children: <Widget>[
                  Icon(
                    size: 70,
                    icon,
                    color: Colors.white,
                  ),
                ],
              ),
              content: Text(
                content,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: AutofillHints.organizationName),
              ),
            )));
  }
}
