import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petzz_project/data_controller.dart';
import 'package:petzz_project/image_picker.dart';
import 'package:petzz_project/login_user_adds.dart';
import 'package:petzz_project/signinscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class uploadScreen extends StatefulWidget {
  const uploadScreen({Key? key}) : super(key: key);

  @override
  State<uploadScreen> createState() => _uploadScreenState();
}

class _uploadScreenState extends State<uploadScreen> {
  final DataController controller = Get.put(DataController());
  var _userImageFile;
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> animalData = {
    "a_name": "",
    "a_tbr": "",
    "a_st": "",
    "a_location": "",
    "a_upload_date": DateTime.now().millisecondsSinceEpoch,
    "a_phone_number": "",
  };

  void _pickedImage(File image) {
    _userImageFile = image;
    print("Image $_userImageFile");
  }

  void addAnimal() {
    if (_userImageFile == null) {
      Get.snackbar(
        "Oops",
        "Image Required",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Theme.of(context).errorColor,
        colorText: Colors.white,
      );
      return;
    }

    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      print("Form is valid");

      print('Data for login $animalData');
      controller.addNewAnimal(animalData, _userImageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade600,
      appBar: AppBar(
          backgroundColor: Colors.yellow.shade700,
          title: const Text('Enter Details'),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'myadds') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginUserAdds()));
                }
                if (value == 'logout') {
                  FirebaseAuth.instance.signOut().then((value) {
                    print("Signed Out");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => signinscreen()));
                  });
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'myadds',
                  child: Text('My Adds', style: TextStyle(color: Colors.black)),
                ),
                PopupMenuItem<String>(
                  value: 'logout',
                  child: Text('Log Out', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ]),
      body: SingleChildScrollView(
        child: Card(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Your Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name Required';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      animalData['a_name'] = value!;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration:
                        const InputDecoration(labelText: 'Phone Number'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone Number Required';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      animalData['a_phone_number'] = value!;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        labelText: 'Animal to be rescued?'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      animalData['a_tbr'] = value!;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration:
                        const InputDecoration(labelText: 'Subjected To'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone Number Required';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      animalData['a_st'] = value!;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(labelText: 'Location'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      animalData['a_location'] = value!;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomImagePicker(_pickedImage),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    onPressed: addAnimal,
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
