// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/screens/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String imageUrl = '';
  var _name = new TextEditingController();
  var _email = new TextEditingController();
  var _phone = new TextEditingController();
  var _weight = new TextEditingController();
  var _height = new TextEditingController();
  var _injury = new TextEditingController();
  Future<void> _addUser() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    const apiUrl = 'https://fitnessjourni.com/api/addUser.php';
    final response = await http.post(Uri.parse(apiUrl), body: {
      'userId': userId,
      'name': _name.text,
      'email': _email.text,
      'phone': _phone.text,
      'weight': _weight,
      'height': _height,
      'injury': _injury.text,
      'imageUrl': imageUrl,
    });
    if (response.statusCode == 200) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MainScreen()));
    }
  }

  File? galleryFile;
  final picker = ImagePicker();
  final items = ['Kgs', 'Lbs'];
  String? value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: 115,
                  width: 115,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(width: 1, color: Colors.black),
                              color: Colors.grey),
                          child: galleryFile == null
                              ? const Center(
                                  child: Text(
                                    "Upload Image",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                )
                              : Center(
                                  child: Image.file(
                                  galleryFile!,
                                  fit: BoxFit.cover,
                                )),
                        ),
                      ),
                      Positioned(
                          right: 0,
                          bottom: 0,
                          child: GestureDetector(
                              onTap: _showDialog,
                              child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.black),
                                  child: const Icon(
                                    Icons.photo_camera_outlined,
                                    size: 35,
                                  ))))
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Divider(
                height: 1.0,
                color: Colors.white,
                thickness: 1.0,
              ),
              const SizedBox(height: 15),
              const Text(
                ' Name',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: 45,
                child: TextFormField(
                  controller: _name,
                  decoration: InputDecoration(
                      label: const Text('Name'),
                      isDense: true,
                      filled: true,
                      //  fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Name';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                ' Email',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: 45,
                child: TextFormField(
                  controller: _email,
                  decoration: InputDecoration(
                      label: const Text('Email'),
                      isDense: true,
                      filled: true,
                      // fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Email';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                ' Phone Number',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: 45,
                child: TextFormField(
                  controller: _phone,
                  decoration: InputDecoration(
                      label: const Text('Phone Number'),
                      isDense: true,
                      filled: true,
                      // fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Phone Number';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                ' Weight',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: 45,
                child: TextFormField(
                  controller: _weight,
                  decoration: InputDecoration(
                      prefix: DropdownButton<String>(
                          elevation: 0,
                          value: value,
                          borderRadius: BorderRadius.circular(5),
                          isDense: true,
                          hint: const Text('Kgs'),
                          items: items.map(buildMenuItem).toList(),
                          onChanged: (value) => setState(() {
                                this.value = value;
                              })),
                      isDense: true,
                      filled: true,
                      //fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                ' Height',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: 45,
                child: TextFormField(
                  controller: _height,
                  decoration: InputDecoration(
                      prefix: DropdownButton(
                          items: [], onChanged: (value) => setState(() {})),
                      isDense: true,
                      filled: true,
                      //  fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                ' Do You Have Any Previous Injuries?',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: 45,
                child: TextFormField(
                  controller: _injury,
                  decoration: InputDecoration(
                      isDense: true,
                      filled: true,
                      // fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              const SizedBox(height: 25),
              Center(
                child: GestureDetector(
                  onTap: () {
                    _addUser();
                  },
                  child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(colors: [
                            Colors.deepOrangeAccent,
                            Colors.amberAccent
                          ])),
                      padding: const EdgeInsets.all(10),
                      child: const Center(
                          child: Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ))),
                ),
              ),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Image.asset(
              'assets/CameraIcon.png',
              height: 60,
              color: Colors.white,
            ),
            content: const Text(
              'Choose from',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Camera',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Gallery',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              )
            ],
          );
        });
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
      );
  Future getImage(
    ImageSource img,
  ) async {
    final pickedFile = await picker.pickImage(source: img);
    XFile? xfilePick = pickedFile;
    setState(
      () {
        if (xfilePick != null) {
          galleryFile = File(pickedFile!.path);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }
}
