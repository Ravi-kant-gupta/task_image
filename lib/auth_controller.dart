import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var obscureText = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() async{
    super.onInit();
  }
  Future<void> userLoginOrNot() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString('token')??'';
    print("=============------${token}");
    if(token != ""){
      Get.offAllNamed("/home");
    }else{
      Get.offAllNamed("/login"); 
    }
  }

  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }

  Future<void> login() async {
    try {
      UserCredential userCradential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      print("==========${userCradential.user}");
      if(userCradential.user != null){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("token", userCradential.user!.uid);
        Get.offAllNamed('/home'); // Navigate to Home Page
        print(prefs.getString("token"));
        errorMessage.value = "";

      }
    } catch (e) {
      errorMessage.value = 'Login failed. Please check your credentials.';
    }
  }

}
