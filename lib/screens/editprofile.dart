// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
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
  String baseimage = "";
  ImagePicker picker = ImagePicker();
  XFile? uploadimage;
  var _name = new TextEditingController();
  var _email = new TextEditingController();
  var _phone = new TextEditingController();
  var _weight = new TextEditingController();
  var _height = new TextEditingController();
  var _injury = new TextEditingController();
  Future<String> getUser() async {
    try {
      String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

      String url = 'https://fitnessjourni.com/api/getUser.php';

      var response = await http.post(Uri.parse(url), body: {'userId': userId});
      print(response.body);
      var jsondata = json.decode(response.body);

      setState(() {
        _name.text = jsondata["name"];
        _phone.text = jsondata['phoneNumber'];
        _email.text = jsondata['email'];
        userId = jsondata['userId'];
        imageUrl = "https://fitnessjourni.com/api/uploads/$userId.jpg";
      });
    } on HandshakeException catch (_) {}
    return "success";
  }

  Future<void> _addUser() async {
    print({
      'name': _name.text,
      'email': _email.text,
      'phoneNumber': _phone.text,
      'weight': _weight.text,
      'height': _height.text,
      'injury': _injury.text,
      'image': imageUrl,
    });
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    const apiUrl = 'https://fitnessjourni.com/api/addUser.php';
    final response = await http.post(Uri.parse(apiUrl), body: {
      'userId': userId,
      'name': _name.text,
      'email': _email.text,
      'phoneNumber': _phone.text,
      'weight': _weight.text,
      'height': _height.text,
      'injury': _injury.text,
      'image': imageUrl,
    });
    if (response.statusCode == 200) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MainScreen()));
    }
  }

  // File? galleryFile;
  // final picker = ImagePicker();
  final items = ['Kgs', 'Lbs'];
  String? value;

  @override
  void initState() {
    getUser();
    super.initState();
  }

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
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(100)),
                        height: 85,
                        width: 85,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: imageUrl,
                            errorWidget: (context, url, error) => const Icon(
                              CupertinoIcons.person,
                              size: 35,
                            ),
                          ),
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
                onPressed: () async {
                  try {
                    var choosedimage =
                        await picker.pickImage(source: ImageSource.camera);
                    setState(() {
                      uploadimage = choosedimage;
                    });
                    List<int> imageBytes = await uploadimage!.readAsBytes();
                    print(choosedimage);
                    String baseimage = base64Encode(imageBytes);
                    print(baseimage);
                    String userId =
                        FirebaseAuth.instance.currentUser?.uid ?? '';
                    String apiUrl =
                        'https://fitnessjourni.com/api/uploadImage.php';
                    var response = await http.post(Uri.parse(apiUrl),
                        body: {'userId': userId, 'image': baseimage});
                    // Check if the image upload was successful
                    if (response.statusCode == 200) {
                      // Show a Snackbar indicating success

                      // Call the getUser function or any other necessary actions
                      setState(() {
                        getUser();
                      });
                    } else {
                      // Show a Snackbar indicating an error
                    }
                  } catch (error) {
                    // Show a Snackbar for any unexpected errors
                  }
                  Navigator.pop(context);
                },
                child: const Text(
                  'Camera',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              MaterialButton(
                onPressed: () async {
                  try {
                    var choosedimage =
                        await picker.pickImage(source: ImageSource.gallery);
                    setState(() {
                      uploadimage = choosedimage;
                    });
                    List<int> imageBytes = await uploadimage!.readAsBytes();
                    print(choosedimage);
                    String baseimage = base64Encode(imageBytes);
                    print(baseimage);
                    String userId =
                        FirebaseAuth.instance.currentUser?.uid ?? '';
                    String apiUrl =
                        'https://fitnessjourni.com/api/uploadImage.php';
                    var response = await http.post(Uri.parse(apiUrl),
                        body: {'userId': userId, 'imageUrl': baseimage});
                    // Check if the image upload was successful
                    if (response.statusCode == 200) {
                      // Show a Snackbar indicating success

                      // Call the getUser function or any other necessary actions
                      setState(() {
                        getUser();
                      });
                    } else {
                      // Show a Snackbar indicating an error
                    }
                  } catch (error) {
                    // Show a Snackbar for any unexpected errors
                  }
                  Navigator.pop(context);
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
}
