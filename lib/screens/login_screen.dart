import 'dart:developer';
import 'package:assign_1/components/custom_button.dart';
import 'package:assign_1/components/custom_text_field.dart';
import 'package:assign_1/components/show_snack_bar.dart';
import 'package:assign_1/constants.dart';
import 'package:assign_1/screens/edit_screen.dart';
import 'package:assign_1/screens/register_screen.dart';
import 'package:assign_1/sqflite/sqflite.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sqflite/sqflite.dart';

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

  LocalDb localDb = LocalDb();

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
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });

                      try {
                        List<Map>? response = await localDb.getData('''
                            SELECT * FROM 'accounts' WHERE email = '${emailController.text}' AND password = '${passController.text}'
                          ''');

                        if (response!.isEmpty) {
                          showSnackBar(context,
                              "Login Failed (Invalid email or password)");
                        } else {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passController.text)
                              .then((value) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  EditScreen(email: emailController.text),
                            ));
                          });
                          log(emailController.text);
                          log(passController.text);
                          showSnackBar(context, "Login Successfully");
                        }
                      } on DatabaseException catch (e) {
                        log(e.toString());
                        showSnackBar(context, "Database problem");
                      } catch (e) {
                        showSnackBar(context, e.toString());
                      }

                      setState(() {
                        isLoading = false;
                      });
                    } else {
                      showSnackBar(context, "Login Failed (Check the Fields)");
                    }
                  },
                  text: 'LOGIN',
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomButton(
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                    });

                    try {
                      List<Map>? response = await localDb.getData('''
                            SELECT * FROM 'accounts' WHERE studId = '20200406'
                          ''');

                      if (response!.isEmpty) {
                        throw Exception("This user doesn't exist");
                      }

                      // print(response[0]);
                      setState(() {
                        emailController.text = response[0]['email'];
                        passController.text = response[0]['password'];
                      });
                    } on DatabaseException catch (e) {
                      log(e.toString());
                      showSnackBar(context, "Database problem");
                    } catch (e) {
                      showSnackBar(context, e.toString());
                    }

                    setState(() {
                      isLoading = false;
                    });
                  },
                  text: "Write demo data",
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
                        Navigator.pushNamed(context, RegisterScreen.id);
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
                const SizedBox(
                  height: 70,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
