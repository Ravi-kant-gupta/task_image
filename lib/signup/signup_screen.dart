import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'signup_controller.dart'; // Import the controller

class SignUpPage extends StatelessWidget {
  final SignUpController signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: signUpController.emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            Obx(() => TextField(
              controller: signUpController.passwordController,
              obscureText: signUpController.obscureText.value,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    signUpController.obscureText.value ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: signUpController.togglePasswordVisibility,
                ),
              ),
            )),
            TextField(
              controller: signUpController.confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Confirm Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: signUpController.signUp,
              child: Text('Sign Up'),
            ),
            Obx(() => signUpController.errorMessage.value.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      signUpController.errorMessage.value,
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                : SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}
