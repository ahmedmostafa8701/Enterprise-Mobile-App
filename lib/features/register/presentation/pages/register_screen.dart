import 'dart:developer';

import 'package:assign_1/components/custom_button.dart';
import 'package:assign_1/components/custom_text_field.dart';
import 'package:assign_1/components/show_snack_bar.dart';
import 'package:assign_1/constants.dart';
import 'package:assign_1/screens/edit_screen.dart';
import 'package:assign_1/sqflite/sqflite.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sqflite/sqflite.dart';

import '../../../restaurants/presentation/pages/restaurants_home.dart';

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

  LocalDb localDb = LocalDb();

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
                  keyboardType: TextInputType.emailAddress,
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
                  keyboardType: TextInputType.number,
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

                      setState(() {
                        isLoading = true;
                      });

                      try {
                        List<Map>? idRes = await localDb.getData('''
                            SELECT * FROM 'accounts' WHERE studId = '${idController.text}'
                          ''');

                        List<Map>? emailRes = await localDb.getData('''
                            SELECT * FROM 'accounts' WHERE email = '${emailController.text}'
                          ''');

                        if ((idRes != null && idRes.isNotEmpty) || (emailRes != null && emailRes.isNotEmpty)) {
                          showSnackBar(context, "Signup Failed (This student already exists)");
                        } else {
                          await localDb.insertData('''
                            INSERT INTO 'accounts' ("studId", "email", "name", "gender", "level", "password", "image")
                            VALUES ('${idController.text}', '${emailController.text}', '${nameController.text}', '$maleOrFemale', '$level', '${passController.text}', 'default image')
                          ''');

                          final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passController.text,
                          ).then((value) async {
                            DatabaseReference ref = FirebaseDatabase.instance.ref("$kUsersCollection/${FirebaseAuth.instance.currentUser!.uid}");

                            await ref.set({
                              "studId": idController.text,
                              "email": emailController.text,
                              "name": nameController.text,
                              "gender": maleOrFemale,
                              "level": level,
                              "password": passController.text,
                              "image": 'default image',
                              "restaurants": [],
                            });
                          });

                          showSnackBar(context, "Signup Success");
                          Navigator.of(context).pushNamed(RestaurantHome.id);
                        }

                      } on DatabaseException catch (e) {
                        log(e.toString());
                        showSnackBar(context, "Database problem");
                      } catch (e) {
                        showSnackBar(context, e.toString());
                      }


                    } else {
                      showSnackBar(context, "Signup Failed (Check the Fields)");
                    }

                    setState(() {
                      isLoading = false;
                    });

                  },
                  text: 'REGISTER',
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
                        nameController.text = response[0]['name'];
                        maleOrFemale = response[0]['gender'];
                        emailController.text = response[0]['email'];
                        idController.text = response[0]['studId'];
                        level = response[0]['level'];
                        passController.text = response[0]['password'];
                        repassController.text = response[0]['password'];
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
                      "you already have an account?",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
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
