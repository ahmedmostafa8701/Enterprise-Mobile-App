import 'dart:developer';

import 'package:assign_1/components/custom_button.dart';
import 'package:assign_1/components/custom_text_field.dart';
import 'package:assign_1/constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static String id = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;
  bool passwordIsHidden = true;
  bool rePasswordIsHidden = true;

  String maleOrFemale = "";
  String level = "";

  RegExp get _emailRegex =>
      RegExp(r'^[a-zA-Z0-9._%+-]+@stud\.fci-cu\.edu\.eg$');

  FocusNode nameFocus = FocusNode();
  FocusNode mailFocus = FocusNode();
  FocusNode idFocus = FocusNode();
  FocusNode passFocus = FocusNode();
  FocusNode repassFocus = FocusNode();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController repassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          foregroundColor: Colors.white,
          surfaceTintColor: kPrimaryColor,
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
                      'Welcome !',
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
                      'REGISTER',
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
                  controller: nameController,
                  validator: (data) {
                    if (data!.isEmpty) {
                      return "The name is required";
                    }
                    return null;
                  },
                  autoFocus: true,
                  focusNode: nameFocus,
                  onFieldSubmit: (value) {
                    FocusScope.of(context).requestFocus(mailFocus);
                    return "";
                  },
                  suffixIcon: const Icon(
                    Icons.drive_file_rename_outline_rounded,
                    color: Colors.white,
                  ),
                  labelText: 'Name',
                  hintText: "Enter your name",
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      "Gender:",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Radio(
                      value: "male",
                      groupValue: maleOrFemale,
                      onChanged: (value) {
                        setState(
                          () {
                            maleOrFemale = value!;
                          },
                        );
                      },
                      activeColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                        (states) {
                          return maleOrFemale != 'male' || maleOrFemale == ''
                              ? Colors.grey
                              : Colors.white;
                        },
                      ),
                    ),
                    Text(
                      "Male",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: maleOrFemale == 'male'
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    Radio(
                      value: "female",
                      groupValue: maleOrFemale,
                      onChanged: (value) {
                        setState(
                          () {
                            maleOrFemale = value!;
                          },
                        );
                      },
                      activeColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                        (states) {
                          return maleOrFemale != 'female' || maleOrFemale == ''
                              ? Colors.grey
                              : Colors.white;
                        },
                      ),
                    ),
                    Text(
                      "Female",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: maleOrFemale == 'female'
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
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
                  onFieldSubmit: (value) {
                    FocusScope.of(context).requestFocus(idFocus);
                    return "";
                  },
                  focusNode: mailFocus,
                  suffixIcon: const Icon(
                    Icons.mail,
                    color: Colors.white,
                  ),
                  labelText: 'Email',
                  hintText: "studentID@stud.fci-cu.edu.eg",
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: idController,
                  validator: (data) {
                    if (data!.isEmpty) {
                      return "The ID is required";
                    }
                    return null;
                  },
                  focusNode: idFocus,
                  onFieldSubmit: (value) {
                    FocusScope.of(context).requestFocus(passFocus);
                    return "";
                  },
                  suffixIcon: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  labelText: 'StudentID',
                  hintText: "Enter your StudentID",
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      "Level:",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Radio(
                      value: "1",
                      groupValue: level,
                      onChanged: (value) {
                        setState(
                          () {
                            level = value!;
                          },
                        );
                      },
                      activeColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                        (states) {
                          return level != '1' || level == ''
                              ? Colors.grey
                              : Colors.white;
                        },
                      ),
                    ),
                    Text(
                      "1",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight:
                            level == '1' ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    Radio(
                      value: "2",
                      groupValue: level,
                      onChanged: (value) {
                        setState(
                          () {
                            level = value!;
                          },
                        );
                      },
                      activeColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                        (states) {
                          return level != '2' || level == ''
                              ? Colors.grey
                              : Colors.white;
                        },
                      ),
                    ),
                    Text(
                      "2",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight:
                            level == '2' ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    Radio(
                      value: "3",
                      groupValue: level,
                      onChanged: (value) {
                        setState(
                          () {
                            level = value!;
                          },
                        );
                      },
                      activeColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                        (states) {
                          return level != '3' || level == ''
                              ? Colors.grey
                              : Colors.white;
                        },
                      ),
                    ),
                    Text(
                      "3",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight:
                            level == '3' ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    Radio(
                      value: "4",
                      groupValue: level,
                      onChanged: (value) {
                        setState(
                          () {
                            level = value!;
                          },
                        );
                      },
                      activeColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                        (states) {
                          return level != '4' || level == ''
                              ? Colors.grey
                              : Colors.white;
                        },
                      ),
                    ),
                    Text(
                      "4",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight:
                            level == '4' ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
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
                  onFieldSubmit: (value) {
                    FocusScope.of(context).requestFocus(repassFocus);
                    return "";
                  },
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
                  height: 10,
                ),
                CustomTextField(
                  controller: repassController,
                  validator: (data) {
                    if (data!.isEmpty) {
                      return "The confirm password is required";
                    } else if (data.length < 8) {
                      return "The confirm password must be at least 8 characters";
                    } else if (passController.text != repassController.text) {
                      return "Password and Confirm Password must match";
                    }
                    return null;
                  },
                  focusNode: repassFocus,
                  labelText: 'Confirm Password',
                  hintText: "Rewrite your password here",
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        rePasswordIsHidden = !rePasswordIsHidden;
                      });
                    },
                    icon: Icon(
                      rePasswordIsHidden
                          ? Icons.visibility_off_sharp
                          : Icons.visibility_sharp,
                      color: Colors.white,
                    ),
                    color: Colors.white,
                  ),
                  obscureText: rePasswordIsHidden,
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      log(nameController.text);
                      log(maleOrFemale);
                      log(emailController.text);
                      log(idController.text);
                      log(level);
                      log(passController.text);
                      log(repassController.text);
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
                      "you already have an account?",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.pushNamed(context, RegisterScreen.id);
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "  Login",
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
