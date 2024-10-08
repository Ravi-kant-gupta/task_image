import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/auth_controller.dart';
import 'package:task/signup/signup_screen.dart';
class LoginPage extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: authController.emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            Obx(() => TextField(
              controller: authController.passwordController,
              obscureText: authController.obscureText.value,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    authController.obscureText.value ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: authController.togglePasswordVisibility,
                ),
              ),
            )),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async{
                await authController.login();
                },
              child: Text('Login'),
            ),
            Obx(() => authController.errorMessage.value.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      authController.errorMessage.value,
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                : SizedBox.shrink()),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Get.to(SignUpPage()); // Navigate to Sign Up Page
              },
              child: Text('Don\'t have an account? Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
