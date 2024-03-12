// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/authentication%20screen/forgetpassword.dart';
import 'package:fitness/authentication%20screen/welcome.dart';
import 'package:fitness/screens/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String imageUrl = "";
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
      var jsondata = json.decode(response.body);
      print(jsondata);

      setState(() {
        _name.text = jsondata["name"];
        _phone.text = jsondata['phoneNumber'];
        _email.text = jsondata['email'];
        // _height.text = jsondata['height'];
        // _weight.text = jsondata['weight'];
        userId = jsondata['userId'];

        imageUrl = "https://fitnessjourni.com/api/uploads/$userId.png";
      });
      print(imageUrl);
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

  String userName = "Enter your name";
  String mobile = "Enter your mobile number";
  String emailString = "Enter your email address";
  String heightString = "Enter your height";
  String weightString = "Enter your weight kgs/lbs";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Edit Profile',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: 'SpaceGrotesk',
              fontSize: 20),
        ),
        centerTitle: true,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            height: 1.0,
            color: const Color(0xff142129),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: showDeletePopup,
            child: SvgPicture.asset(
              'assets/svg/delete.svg',
              height: 18,
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.white),
                          borderRadius: BorderRadius.circular(100),
                          color: const Color(0xff142129)),
                      height: 85,
                      width: 85,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: imageUrl,
                            errorWidget: (context, url, error) => Container(
                                  padding: const EdgeInsets.all(25),
                                  child: SvgPicture.asset(
                                    'assets/svg/fjuser.svg',
                                    height: 10,
                                    width: 10,
                                  ),
                                )),
                      ),
                    ),
                    Positioned(
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                            onTap: () async {
                              try {
                                var choosedimage = await picker.pickImage(
                                    source: ImageSource.gallery);
                                setState(() {
                                  uploadimage = choosedimage;
                                });
                                List<int> imageBytes =
                                    await uploadimage!.readAsBytes();
                                print(choosedimage);
                                String baseimage = base64Encode(imageBytes);
                                print(baseimage);
                                String userId =
                                    FirebaseAuth.instance.currentUser?.uid ??
                                        '';
                                String apiUrl =
                                    'https://fitnessjourni.com/api/uploadImage.php';
                                var response = await http
                                    .post(Uri.parse(apiUrl), body: {
                                  'userId': userId,
                                  'imageUrl': baseimage
                                });
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
                            },
                            child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    border: Border.all(
                                        width: 1.5, color: Colors.white)),
                                child:
                                    SvgPicture.asset('assets/svg/edit.svg'))))
                  ],
                ),
              ),
              const SizedBox(height: 25),
              TextFormField(
                controller: _name,
                decoration: InputDecoration(
                  isDense: true,
                  floatingLabelStyle: const TextStyle(
                      fontFamily: 'WorkSans',
                      fontSize: 20,
                      color: Color(0xffB3BAC3)),
                  labelText: userName,
                  labelStyle: const TextStyle(
                      fontFamily: 'WorkSans',
                      fontSize: 16,
                      color: Color(0xffB3BAC3)),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: Colors.white,
                          style: BorderStyle.solid)),
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: Colors.white,
                          style: BorderStyle.solid)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter user name';
                  }
                  return null;
                },
                onTap: () {
                  setState(() {
                    userName = "Name";
                  });
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _phone,
                decoration: InputDecoration(
                  fillColor: const Color(0xff142129),
                  filled: true,
                  prefix: RichText(
                      text: const TextSpan(
                          text: '+971',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffFF6600),
                              fontFamily: 'SpaceGrotesk'),
                          children: [
                        TextSpan(
                            text: '  |  ',
                            style: TextStyle(color: Color(0xffD9DDE1)))
                      ])),
                  isDense: true,
                  floatingLabelStyle: const TextStyle(
                      fontFamily: 'WorkSans',
                      fontSize: 20,
                      color: Color(0xffB3BAC3)),
                  labelText: mobile,
                  labelStyle: const TextStyle(
                      fontFamily: 'WorkSans',
                      fontSize: 16,
                      color: Color(0xffB3BAC3)),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: Colors.white,
                          style: BorderStyle.solid)),
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: Colors.white,
                          style: BorderStyle.solid)),
                ),
                onTap: () {
                  setState(() {
                    mobile = "Mobile Number";
                  });
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _email,
                decoration: InputDecoration(
                  isDense: true,
                  floatingLabelStyle: const TextStyle(
                      fontFamily: 'WorkSans',
                      fontSize: 20,
                      color: Color(0xffB3BAC3)),
                  labelText: emailString,
                  labelStyle: const TextStyle(
                      fontFamily: 'WorkSans',
                      fontSize: 16,
                      color: Color(0xffB3BAC3)),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: Colors.white,
                          style: BorderStyle.solid)),
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: Colors.white,
                          style: BorderStyle.solid)),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? 'Enter a valid email'
                        : null,
                onTap: () {
                  setState(() {
                    emailString = "Email Address";
                  });
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _height,
                decoration: InputDecoration(
                  isDense: true,
                  floatingLabelStyle: const TextStyle(
                      fontFamily: 'WorkSans',
                      fontSize: 20,
                      color: Color(0xffB3BAC3)),
                  labelText: heightString,
                  labelStyle: const TextStyle(
                      fontFamily: 'WorkSans',
                      fontSize: 16,
                      color: Color(0xffB3BAC3)),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: Colors.white,
                          style: BorderStyle.solid)),
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: Colors.white,
                          style: BorderStyle.solid)),
                ),
                onTap: () {
                  setState(() {
                    heightString = "Height";
                  });
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _weight,
                decoration: InputDecoration(
                  isDense: true,
                  floatingLabelStyle: const TextStyle(
                      fontFamily: 'WorkSans',
                      fontSize: 20,
                      color: Color(0xffB3BAC3)),
                  labelText: weightString,
                  labelStyle: const TextStyle(
                      fontFamily: 'WorkSans',
                      fontSize: 16,
                      color: Color(0xffB3BAC3)),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: Colors.white,
                          style: BorderStyle.solid)),
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: Colors.white,
                          style: BorderStyle.solid)),
                ),
                onTap: () {
                  setState(() {
                    weightString = "Weight";
                  });
                },
              ),
              const SizedBox(height: 25),
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 56)),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotPassword()));
                  },
                  child: const Text(
                    'Change Password',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'SpaceGrotesk',
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  )),
              const SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 56)),
                        onPressed: () {
                          _name.clear();
                          _phone.clear();
                          _email.clear();
                          _height.clear();
                          _weight.clear();
                        },
                        child: const Text(
                          'Undo',
                          style: TextStyle(
                              fontFamily: 'SpaceGrotesk',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        )),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 56)),
                        onPressed: () {
                          _addUser();
                        },
                        child: const Text(
                          'Save Changes',
                          style: TextStyle(
                              fontFamily: 'SpaceGrotesk',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        )),
                  ),
                ],
              ),
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

  Future<void> showDeletePopup() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(width: 1, color: Colors.white)),
          // titlePadding: const EdgeInsets.only(left: 40, right: 40, top: 25),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          title: const Text(
            'Are you sure you want to delete\nyour account?',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          content: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: const Size(154, 56),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  child: const Text(
                    'Back',
                    style: TextStyle(
                        fontFamily: 'SpaceGrotesk',
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      minimumSize: const Size(154, 56),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side:
                              const BorderSide(width: 1, color: Colors.white))),
                  child: const Text(
                    'Delete',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'SpaceGrotesk',
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => const Center(
                                child: CircularProgressIndicator.adaptive(
                              backgroundColor: Colors.white,
                            )));
                    Future.delayed(const Duration(seconds: 1), () async {
                      String userId =
                          FirebaseAuth.instance.currentUser?.uid ?? '';
                      var url = Uri.parse(
                          'https://fitnessjourni.com/api/deleteUser.php');
                      await http
                          .post(url, body: {"userId": userId}).then((value) {
                        FirebaseAuth.instance.currentUser?.delete();
                      });

                      await FirebaseAuth.instance.signOut();

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const Welcome()),
                          ModalRoute.withName('/'));
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
      );
}
