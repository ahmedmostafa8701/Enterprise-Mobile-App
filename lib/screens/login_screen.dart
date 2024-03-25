// import 'package:chat_app/components/custom_button.dart';
// import 'package:chat_app/components/custom_text_field.dart';
// import 'package:chat_app/constants.dart';
// import 'package:chat_app/helper/show_snack_bar.dart';
// import 'package:chat_app/screens/chat_screen.dart';
// import 'package:chat_app/screens/register_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

import 'package:assign_1/components/custom_button.dart';
import 'package:assign_1/components/custom_text_field.dart';
import 'package:assign_1/components/show_snack_bar.dart';
import 'package:assign_1/constants.dart';
import 'package:assign_1/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static String id = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;
  bool passwordIsHidden = true;

  FocusNode mailFocus = FocusNode();
  FocusNode passFocus = FocusNode();

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  RegExp get _emailRegex =>
      RegExp(r'^[a-zA-Z0-9._%+-]+@stud\.fci-cu\.edu\.eg$');

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
        ),
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(
                  height: 75,
                ),
                const Column(
                  children: [
                    Text(
                      'Welcome Back !',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontFamily: 'Pacifico',
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 100,
                ),
                const Row(
                  children: [
                    Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextField(
                  controller: emailController,
                  validator: (data) {
                    if (data!.isEmpty) {
                      return "The Email is required";
                    } else if (!_emailRegex.hasMatch(data)) {
                      return 'Email address is not valid';
                    }
                    return null;
                  },
                  suffixIcon: const Icon(
                    Icons.mail,
                    color: Colors.white,
                  ),
                  autoFocus: true,
                  focusNode: mailFocus,
                  onFieldSubmit: (value) {
                    FocusScope.of(context).requestFocus(passFocus);
                    return "";
                  },
                  labelText: 'Email',
                  hintText: "Write your Email here",
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: passController,
                  validator: (data) {
                    if (data!.isEmpty) {
                      return "The Password is required";
                    } else if (data.length < 8) {
                      return "The Password must be at least 8 characters";
                    }
                    return null;
                  },
                  focusNode: passFocus,
                  labelText: 'Password',
                  hintText: "Write your password here",
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        passwordIsHidden = !passwordIsHidden;
                      });
                    },
                    icon: Icon(
                      passwordIsHidden
                          ? Icons.visibility_off_sharp
                          : Icons.visibility_sharp,
                      color: Colors.white,
                    ),
                    color: Colors.white,
                  ),
                  obscureText: passwordIsHidden,
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      log(emailController.text);
                      log(passController.text);
                      showSnackBar(context, "Login Success");
                    } else {
                      showSnackBar(context, "Login Failed");
                    }
                  },
                  text: 'LOGIN',
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "don't have an account?",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.pushNamed(context, RegisterScreen.id);
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ));
                      },
                      child: const Text(
                        "  Register",
                        style: TextStyle(
                          color: Color(0xFFC4ECE4),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// Future<void> loginUser() async {
//   UserCredential user =
//   await FirebaseAuth.instance.signInWithEmailAndPassword(
//     email: email!,
//     password: password!,
//   );
// }
}
