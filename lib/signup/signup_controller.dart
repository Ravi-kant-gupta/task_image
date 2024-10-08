import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var obscureText = true.obs;
  var errorMessage = ''.obs;

  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }

  Future<void> signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      errorMessage.value = 'Passwords do not match.';
      return;
    }

    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if(user.user!.uid != null){
        Get.offAllNamed('/'); // Navigate to Home Page after successful sign-up
      }else{
        Get.snackbar("Error", "Not Created");
      }
    }on FirebaseAuthException catch (e) {
    // Handle specific FirebaseAuthException codes
    String message;
    switch (e.code) {
      case 'weak-password':
        errorMessage.value = 'The password provided is too weak.';
        break;
      case 'email-already-in-use':
        errorMessage.value = 'The account already exists for that email.';
        break;
      case 'invalid-email':
        errorMessage.value = 'The email address is not valid.';
        break;
      default:
        errorMessage.value = 'Sign-up failed. Please try again.';
        break;
    }
    // Show the error message using Get.snackbar
    // Get.snackbar("Sign-up Error", message);
  }  catch (e) {
      print("=====${e}");
      errorMessage.value = 'Sign-up failed. Please try again.';
    }
  }
}
