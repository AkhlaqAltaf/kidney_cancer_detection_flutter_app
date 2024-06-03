import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kidney_cancer_detection/providers/authProvider.dart';
import 'package:kidney_cancer_detection/providers/doctor_provider.dart';
import 'package:kidney_cancer_detection/screens/utility_screens/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AuthentcationProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => DoctorProvider(),
          )
        ],
        builder: (context, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                appBarTheme: const AppBarTheme(
                  backgroundColor: Color.fromRGBO(112, 22, 54, 20),
                  iconTheme: IconThemeData(color: Colors.white),
                ),
                useMaterial3: true,
                fontFamily: ('inter'),
              ),
              home: const WelcomeScreen(),
            ));
  }
}
