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
     // backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                image: AssetImage('assets/ems jacket.webp'),
                fit: BoxFit.contain,
                opacity: 0.98,
              )),
          child: SingleChildScrollView(
            child: Column(
              children: [
                 Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.black.withOpacity(0.5)),
                  child: Image.asset('assets/FJ FONT.png'),
                 ),
                const SizedBox(
                  height: 80,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black.withOpacity(0.2)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              controller: _userNameController,
                              decoration: InputDecoration(
                                 
                                  hintText: 'User Name',
                                  isDense: true,
                                  filled: true,
                                  fillColor: Colors.black54,
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
                              style: const TextStyle(color: Colors.white),
                              enabled: false,
                              decoration: InputDecoration(
                                 
                                  hintText: 'Email',
                                  isDense: true,
                                  filled: true,
                                  fillColor: Colors.black54,
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
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                  isDense: true,
                                  filled: true,
                                  fillColor: Colors.black54,
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
