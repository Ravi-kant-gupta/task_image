import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/home/home_screen.dart';
import 'package:task/login/login_page.dart';
import 'package:task/signup/signup_screen.dart';

import 'auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyD87QejOcwKcD7XAIHwTUUznuzkYsYaln4',
    appId: '1:144333009677:android:75fee772e2b25234247644',
    messagingSenderId: '144333009677',
    projectId: 'task-2587d',
    storageBucket: 'gs://task-2587d.appspot.com',
  )).whenComplete(() => print("Complete"));
  Get.put(AuthController()); // Initialize the AuthController
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.blueGrey[700],
              foregroundColor: Colors.white)),
      title: 'Login App',
      initialRoute: '/',
      home: YourInitialScreen(),
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/signup', page: () => SignUpPage()),
        GetPage(
            name: '/home',
            page: () => HomeScreen()), // Ensure you have a HomePage defined
      ],
    );
  }
}

class YourInitialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    // Check if the user is logged in or not
    authController.userLoginOrNot();

    return Scaffold(
      body: Center(
          child:
              CircularProgressIndicator()), // Show loading while checking login status
    );
  }
}
