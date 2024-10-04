import 'package:fingara_mad02/authentication/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController firstNameTextEditingController = TextEditingController();
  TextEditingController lastNameTextEditingController = TextEditingController();
  TextEditingController contactNoTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController = TextEditingController();

  String? errorMessage;

  @override
  void dispose() {
    firstNameTextEditingController.dispose();
    lastNameTextEditingController.dispose();
    contactNoTextEditingController.dispose();
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    confirmPasswordTextEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [

          SizedBox(
            height: screenSize.height,
            width: screenSize.width,
            child: Image.asset(
              'assets/images/registerPage_MAD.webp',
              fit: BoxFit.cover,
            ),
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),

          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: screenSize.width * 0.8,
                maxHeight: screenSize.height,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 40.0),
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),

                          TextField(
                            controller: firstNameTextEditingController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: "First Name",
                              labelStyle: TextStyle(
                                fontSize: 18,
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 15),
                          TextField(
                            controller: lastNameTextEditingController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: "Last Name",
                              labelStyle: TextStyle(
                                fontSize: 18,
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 15),
                          TextField(
                            controller: contactNoTextEditingController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              labelText: "Contact number",
                              labelStyle: TextStyle(
                                fontSize: 18,
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 15),
                          TextField(
                            controller: emailTextEditingController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: "Email Address",
                              labelStyle: TextStyle(
                                fontSize: 18,
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 15),
                          TextField(
                            controller: passwordTextEditingController,
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: const InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(
                                fontSize: 18,
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 15),
                          TextField(
                            controller: confirmPasswordTextEditingController,
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: const InputDecoration(
                              labelText: "Confirm Password",
                              labelStyle: TextStyle(
                                fontSize: 18,
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 15),
                          if (errorMessage != null) ...[
                            Text(
                              errorMessage!,
                              style: TextStyle(color: Colors.red),
                            ),
                            SizedBox(height: 10),
                          ],
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                register();
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                                padding: EdgeInsets.symmetric(horizontal: screenSize.width*0.1, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              Text("Already an User? ",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/login');
                                },
                                child: Text('Login',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(200, 217, 111, 1),
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void register() async {
    String firstName = firstNameTextEditingController.text;
    String lastName = lastNameTextEditingController.text;
    String contactNo = contactNoTextEditingController.text;
    String email = emailTextEditingController.text;
    String password = passwordTextEditingController.text;
    String confirmPassword = confirmPasswordTextEditingController.text;

    setState(() {
      errorMessage = '';
    });

    // Checks whether the Input Fields are Empty or not
    if (firstName.isEmpty || lastName.isEmpty || contactNo.isEmpty ||
        email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      setState(() {
        errorMessage = "Please fill in all the fields.";
      });
      return;
    }

    // Check if Password and Confirm Password matches
    if (password != confirmPassword) {
      setState(() {
        errorMessage = "Passwords do not match.";
      });
      return;
    }

    try {
      User? user = await _auth.registerWithUserCredentials(email, password);

      if (user != null) {
        await FirebaseFirestore.instance.collection('Users').doc(user.uid).set({
          'firstName': firstName,
          'lastName': lastName,
          'contactNo': contactNo,
          'email': email,
        });

        Navigator.pushNamed(context, '/home');
      }
    } catch (e) {
      setState(() {
        errorMessage = "An unexpected error occurred.";
      });
    }
  }

}
