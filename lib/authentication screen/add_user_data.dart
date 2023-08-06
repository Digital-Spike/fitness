import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/constants/api_list.dart';
import 'package:fitness/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final _userNameController = TextEditingController();
  String _phoneNumber = "";
  User? user = FirebaseAuth.instance.currentUser;

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                image: AssetImage('assets/IMG_9779.jpg'),
                fit: BoxFit.cover,
                opacity: 0.98,
              )),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black.withOpacity(0.3)),
                    child: const Column(
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'Transform your body\nand mind',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'with the ultimate EMS fitness journey app for anyone who wants to take control of their health and fitness',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black.withOpacity(0.3)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              style: const TextStyle(color: Colors.black),
                              controller: _userNameController,
                              decoration: InputDecoration(
                                  label: const Text(
                                    'User Name',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  hintText: 'User Name',
                                  isDense: true,
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter user name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              initialValue: user?.email,
                              style: const TextStyle(color: Colors.black),
                              enabled: false,
                              decoration: InputDecoration(
                                  label: const Text(
                                    'Email',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  hintText: 'Email',
                                  isDense: true,
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (email) => email != null &&
                                      !EmailValidator.validate(email)
                                  ? 'Enter a valid email'
                                  : null,
                            ),
                            const SizedBox(height: 15),
                            IntlPhoneField(
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                  isDense: true,
                                  filled: true,
                                  fillColor: Colors.white60,
                                  labelStyle: TextStyle(color: Colors.grey),
                                  labelText: 'Phone Number',
                                  hintText: 'Phone Number',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)))),
                              disableLengthCheck: true,
                              initialCountryCode: 'AE',
                              onChanged: (phone) {
                                _phoneNumber = phone.completeNumber;
                              },
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                                onTap: () => saveUserData(),
                                child: SvgPicture.asset('assets/save.svg')),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  saveUserData() async {
    if (formKey.currentState!.validate()) {
      var url = Uri.parse('${ApiList.apiUrl}/addUser.php');
      Map<String, dynamic> userData = {
        'name': _userNameController.text,
        'userId': user?.uid,
        'phoneNumber': _phoneNumber,
        'email': user?.email,
      };
      await http.post(url, body: userData);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const HomePage()),
          ModalRoute.withName('/'));
    }
  }
}
