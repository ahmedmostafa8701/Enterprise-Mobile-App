import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:assign_1/components/custom_button.dart';
import 'package:assign_1/components/custom_text_field.dart';
import 'package:assign_1/components/show_snack_bar.dart';
import 'package:assign_1/constants.dart';
import 'package:assign_1/sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sqflite/sqflite.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key, required this.email});

  // static String id = 'EditScreen';
  final String email;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;
  bool passwordIsHidden = true;
  bool rePasswordIsHidden = true;
  bool enabled = false;

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
  List<Map>? currentResponse;

  File? image;
  String? localImage;

  Future uploadImage() async {
    if (image == null) {
      return;
    }

    String base64 = base64Encode(image!.readAsBytesSync());
    String imageName = image!.path.split("/").last;
    log(base64);
    log(imageName);
    log(image!.path);
  }

  @override
  void initState() {
    super.initState();

    getData();
    log(widget.email);
  }

  void getData() async {
    setState(() {
      isLoading = true;
    });

    try {
    currentResponse = await localDb.getData('''
                            SELECT * FROM 'accounts' WHERE email = '${widget.email}'
                          ''');

    if (currentResponse!.isEmpty) {
      throw Exception("This user doesn't exist");
    }

    // print(currentResponse[0]);
    setState(() {
      nameController.text = currentResponse![0]['name'];
      maleOrFemale = currentResponse![0]['gender'];
      emailController.text = currentResponse![0]['email'];
      idController.text = currentResponse![0]['studId'];
      level = currentResponse![0]['level'];
      passController.text = currentResponse![0]['password'];
      repassController.text = currentResponse![0]['password'];
      localImage = currentResponse![0]['image'];

      if (localImage == 'default image') {
        image = null;
      } else {
        image = File(localImage!);
      }
    });

    }
    on DatabaseException catch (e) {
      log(e.toString());
      showSnackBar(context, "Database problem");
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  getImage() async {
    bool? isCamera = await showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        color: Colors.grey[850],
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/camera.png',
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "Camera",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/gallary.png',
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "Gallery",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    if (isCamera == null) return;

    try {
      final file = await ImagePicker().pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery,
      );
      image = File(file!.path);
    } catch (e) {
      showSnackBar(context, "The image is not selected");
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          foregroundColor: Colors.white,
          title: const Text(
            "Edit",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontFamily: 'Pacifico',
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 35,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 85,
                          backgroundColor: Colors.deepPurpleAccent,
                        ),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 80,
                              child: ClipOval(
                                child: SizedBox(
                                  width: 160,
                                  height: 160,
                                  child: image == null
                                      ? Image.asset(
                                          "assets/images/default_Image.jpg",
                                        )
                                      : Image.file(
                                          image!,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ),
                            enabled
                                ? CircleAvatar(
                                    backgroundColor: kPrimaryColor,
                                    foregroundColor: Colors.white,
                                    radius: 25,
                                    child: IconButton(
                                      onPressed: getImage,
                                      icon: const Icon(Icons.edit),
                                    ),
                                  )
                                : const Text(""),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    CustomTextField(
                      enabled: enabled,
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
                        FocusScope.of(context).requestFocus(passFocus);
                        return "";
                      },
                      suffixIcon: Icon(
                        Icons.drive_file_rename_outline_rounded,
                        color: enabled ? Colors.white : Colors.grey,
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
                          onChanged: enabled
                              ? (value) {
                                  setState(
                                    () {
                                      maleOrFemale = value!.toString();
                                    },
                                  );
                                }
                              : null,
                          activeColor: Colors.white,
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                            (states) {
                              return maleOrFemale != 'male' ||
                                      maleOrFemale == '' ||
                                      enabled == false
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
                          onChanged: enabled
                              ? (value) {
                                  setState(
                                    () {
                                      maleOrFemale = value!.toString();
                                    },
                                  );
                                }
                              : null,
                          activeColor: Colors.white,
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                            (states) {
                              return maleOrFemale != 'female' ||
                                      maleOrFemale == '' ||
                                      enabled == false
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
                      enabled: false,
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
                        color: Colors.grey,
                      ),
                      labelText: 'Email',
                      hintText: "studentID@stud.fci-cu.edu.eg",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      enabled: false,
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
                        color: Colors.grey,
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
                          onChanged: enabled
                              ? (value) {
                                  setState(
                                    () {
                                      level = value!.toString();
                                    },
                                  );
                                }
                              : null,
                          activeColor: Colors.white,
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                            (states) {
                              return level != '1' ||
                                      level == '' ||
                                      enabled == false
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
                            fontWeight: level == '1'
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        Radio(
                          value: "2",
                          groupValue: level,
                          onChanged: enabled
                              ? (value) {
                                  setState(
                                    () {
                                      level = value!.toString();
                                    },
                                  );
                                }
                              : null,
                          activeColor: Colors.white,
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                            (states) {
                              return level != '2' ||
                                      level == '' ||
                                      enabled == false
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
                            fontWeight: level == '2'
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        Radio(
                          value: "3",
                          groupValue: level,
                          onChanged: enabled
                              ? (value) {
                                  setState(
                                    () {
                                      level = value!.toString();
                                      // print(value);
                                    },
                                  );
                                }
                              : null,
                          activeColor: Colors.white,
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                            (states) {
                              return level != '3' ||
                                      level == '' ||
                                      enabled == false
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
                            fontWeight: level == '3'
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        Radio(
                          value: "4",
                          groupValue: level,
                          onChanged: enabled
                              ? (value) {
                                  setState(
                                    () {
                                      level = value!.toString();
                                    },
                                  );
                                }
                              : null,
                          activeColor: Colors.white,
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                            (states) {
                              return level != '4' ||
                                      level == '' ||
                                      enabled == false
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
                            fontWeight: level == '4'
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
                      enabled: enabled,
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
                          color: enabled ? Colors.white : Colors.grey,
                        ),
                        color: Colors.white,
                      ),
                      obscureText: passwordIsHidden,
                    ),
                    Builder(
                      builder: (context) {
                        if (enabled) {
                          return Column(
                            children: [
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
                                  } else if (passController.text !=
                                      repassController.text) {
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
                            ],
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Builder(
                      builder: (context) {
                        if (enabled) {
                          return CustomButton(
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });

                                try {
                                  if (nameController.text !=
                                          currentResponse![0]['name'] ||
                                      maleOrFemale !=
                                          currentResponse![0]['gender'] ||
                                      level != currentResponse![0]['level'] ||
                                      passController.text !=
                                          currentResponse![0]['password'] ||
                                      image!.path !=
                                          currentResponse![0]['image']) {
                                    if (nameController.text !=
                                        currentResponse![0]['name']) {
                                      await localDb.updateData('''
                                                                  UPDATE 'accounts' SET "name" = '${nameController.text}' WHERE email = '${widget.email}'
                                                                  ''');
                                    }

                                    if (maleOrFemale !=
                                        currentResponse![0]['gender']) {
                                      await localDb.updateData('''
                                                                  UPDATE 'accounts' SET "gender" = '$maleOrFemale' WHERE email = '${widget.email}'
                                                                  ''');
                                    }

                                    if (level != currentResponse![0]['level']) {
                                      await localDb.updateData('''
                                                                  UPDATE 'accounts' SET "level" = '$level' WHERE email = '${widget.email}'
                                                                  ''');
                                    }

                                    if (passController.text !=
                                        currentResponse![0]['password']) {
                                      log('pass updated');
                                      await localDb.updateData('''
                                                                  UPDATE 'accounts' SET "password" = '${passController.text}' WHERE email = '${widget.email}'
                                                                  ''');
                                    }

                                    if (image!.path !=
                                        currentResponse![0]['image']) {
                                      await localDb.updateData('''
                                                                  UPDATE 'accounts' SET "image" = '${image!.path}' WHERE email = '${widget.email}'
                                                                  ''');
                                      log('image updated');
                                    }

                                    showSnackBar(context, "Updating Succeed");
                                    getData();
                                  } else {
                                    showSnackBar(context, "No Fields Changed");
                                  }
                                } on DatabaseException catch (e) {
                                  log(e.toString());
                                  showSnackBar(context, "Database problem");
                                } catch (e) {
                                  showSnackBar(context, e.toString());
                                }

                                setState(() {
                                  isLoading = false;
                                  enabled = !enabled;
                                });
                              } else {
                                showSnackBar(context, "Updating Failed");
                              }
                            },
                            text: "Save",
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    CustomButton(
                      onTap: () async {
                        setState(() {
                          enabled = !enabled;

                          if (!enabled) {
                            showSnackBar(context, "Update is Canceled");

                            // To remove error messages if appeared
                            formKey.currentState!.reset();
                            getData();
                          }
                        });
                      },
                      background: enabled ? Colors.transparent : Colors.white,
                      textColor: enabled ? Colors.white : Colors.black,
                      text: enabled ? "Cancel" : "EDIT",
                    ),
                    const SizedBox(
                      height: 30,
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
}
