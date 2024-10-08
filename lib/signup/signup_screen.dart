// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'signup_controller.dart'; // Import the controller

// class SignUpPage extends StatelessWidget {
//   final SignUpController signUpController = Get.put(SignUpController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sign Up'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: signUpController.emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//             ),
//             Obx(() => TextField(
//                   controller: signUpController.passwordController,
//                   obscureText: signUpController.obscureText.value,
//                   decoration: InputDecoration(
//                     labelText: 'Password',
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         signUpController.obscureText.value
//                             ? Icons.visibility
//                             : Icons.visibility_off,
//                       ),
//                       onPressed: signUpController.togglePasswordVisibility,
//                     ),
//                   ),
//                 )),
//             TextField(
//               controller: signUpController.confirmPasswordController,
//               obscureText: true,
//               decoration: InputDecoration(labelText: 'Confirm Password'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: signUpController.signUp,
//               child: Text('Sign Up'),
//             ),
//             Obx(() => signUpController.errorMessage.value.isNotEmpty
//                 ? Padding(
//                     padding: const EdgeInsets.only(top: 20),
//                     child: Text(
//                       signUpController.errorMessage.value,
//                       style: TextStyle(color: Colors.red),
//                     ),
//                   )
//                 : SizedBox.shrink()),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'signup_controller.dart'; // Import the controller

class SignUpPage extends StatelessWidget {
  final SignUpController signUpController = Get.put(SignUpController());
  final _formKey = GlobalKey<FormState>(); // Form key for validation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Assign the form key
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Create Your Account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[700],
                ),
              ),
              SizedBox(height: 40),
              TextFormField(
                controller: signUpController.emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Obx(() => TextFormField(
                    controller: signUpController.passwordController,
                    obscureText: signUpController.obscureText.value,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          signUpController.obscureText.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: signUpController.togglePasswordVisibility,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  )),
              SizedBox(height: 20),
              TextFormField(
                controller: signUpController.confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != signUpController.passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    signUpController.signUp();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[700],
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Obx(() => signUpController.errorMessage.value.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        signUpController.errorMessage.value,
                        style: TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : SizedBox.shrink()),
            ],
          ),
        ),
      ),
    );
  }
}
