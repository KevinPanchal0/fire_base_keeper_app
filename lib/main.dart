import 'package:fire_base_keeper_app/views/pages/home_page.dart';
import 'package:fire_base_keeper_app/views/pages/sign_in_page.dart';
import 'package:fire_base_keeper_app/views/pages/sign_up_page.dart';
import 'package:fire_base_keeper_app/views/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash',
      routes: {
        '/': (context) => HomePage(),
        'splash': (context) => SplashScreen(),
        'sign_up_page': (context) => SignUpPage(),
        'sign_in_page': (context) => SignInPage(),
      },
    );
  }
}
