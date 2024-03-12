import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/screens/main_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FreeTrialSession extends StatefulWidget {
  final Map<String, dynamic> trainer;
  final bool isBranch;
  const FreeTrialSession(
      {super.key, required this.trainer, required this.isBranch});

  @override
  State<FreeTrialSession> createState() => _FreeTrialSessionState();
}

class _FreeTrialSessionState extends State<FreeTrialSession> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _cityController = TextEditingController();
  final _phoneController = TextEditingController();
  final _userNameController = TextEditingController();
  final _timeController = TextEditingController();

  TimeOfDay _timeOfDay = TimeOfDay.now();

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
            data: ThemeData.dark().copyWith(primaryColor: Colors.black),
            child: child!);
      },
    ).then((value) {
      setState(() {
        _timeOfDay = value!;
      });
    });
  }

  void _submitForm() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (_userNameController.text.isEmpty &&
          _cityController.text.isEmpty &&
          _emailController.text.isEmpty &&
          _phoneController.text.isEmpty) {
        // No data added, return without saving
        return;
      }
      // Start loading
      // Call API to save user data
      _addUser();
    } else {
      // Form validation failed, stop loading
    }
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((_) {
      _showModelBottom();
    });

    super.initState();
  }

  String userName = "Enter your name";
  String mobile = "Enter your mobile number";
  String emailString = "Enter your email address";
  String city = "Enter your city";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Book Free Trial',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: 'SpaceGrotesk'),
        ),
        centerTitle: true,
        elevation: 0,
        bottom: PreferredSize(
            child: Container(
              height: 1.0,
              color: const Color(0xff142129),
            ),
            preferredSize: const Size.fromHeight(1.0)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _userNameController,
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
                const SizedBox(height: 20),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
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
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
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
                const SizedBox(height: 20),
                TextFormField(
                  controller: _cityController,
                  decoration: InputDecoration(
                    isDense: true,
                    floatingLabelStyle: const TextStyle(
                        fontFamily: 'WorkSans',
                        fontSize: 20,
                        color: Color(0xffB3BAC3)),
                    labelText: city,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter city';
                    }
                    return null;
                  },
                  onTap: () {
                    setState(() {
                      city = "city";
                    });
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  'Select a time so our team can contact you',
                  style: TextStyle(
                      fontFamily: 'SpaceGrotesk',
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _showTimePicker,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 1, color: Colors.white))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Select time',
                              style: TextStyle(
                                  fontFamily: 'WorkSans',
                                  fontSize: 16,
                                  color: Color(0xffB3BAC3)),
                            ),
                            Text(
                              _timeOfDay.format(context).toString(),
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                        SvgPicture.asset(
                          'assets/svg/watch.svg',
                          height: 25,
                        )
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 56)),
                    onPressed: () {
                      _submitForm();
                      showPopup();
                    },
                    child: const Text(
                      'Book',
                      style: TextStyle(
                          fontFamily: 'SpaceGrotesk',
                          fontSize: 18,
                          color: Colors.black),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showModelBottom() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            side: BorderSide(width: 1.5, color: Color(0xff142129)),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        isScrollControlled: true,
        context: context,
        builder: (
          BuildContext context,
        ) {
          return BottomSheet(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              onClosing: () {},
              builder: (BuildContext context) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                  height: MediaQuery.of(context).size.height / 1.3,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Reasons To Start EMS',
                          style: TextStyle(
                              fontFamily: 'SpaceGrotesk',
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffFF6600)),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '*  Get ready to transform your body with our 20 minutes Ems training in Dubai. Experience the benefits of this highly-effective training method for yourself!',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontFamily: 'WorkSans',
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '*  Personal Ems fitness trainers in Dubai are here to guide and motivate you every step of the way. Book your session now and take that first step towards a stronger, healthier you',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontFamily: 'WorkSans',
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "*  Start before you're ready with our EMS Fitness Training! Don't just wait to step out of your comfort zone, push yourself with EMS today!",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontFamily: 'WorkSans',
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '*  Elevate your fitness routine with the latest technology: Electrical stimulation workout in Dubai! Improve muscle strength, endurance, and tone with personalized sessions designed to maximize your results.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontFamily: 'WorkSans',
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 56),
                              backgroundColor: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Book Free Trial',
                            style: TextStyle(
                                fontFamily: 'SpaceGrotesk',
                                fontSize: 18,
                                color: Colors.black),
                          ))
                    ],
                  ),
                );
              });
        });
  }

  Future<void> _addUser() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    const apiUrl = 'https://fitnessjourni.com/api/addqueries.php';
    final response = await http.post(Uri.parse(apiUrl), body: {
      'userId': userId,
      'name': _userNameController.text,
      'email': _emailController.text,
      'phone': _phoneController.text,
      'city': _cityController.text,
      'callTime': _timeOfDay.format(context).toString()
    });
    if (response.statusCode == 200) {
      showPopup();
    }
  }

  Future<void> showPopup() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(width: 1, color: Colors.white)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          title: const Text(
            'Free Trial Session has been booked succefully our team will contact you in a while.',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          content: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: const Size(154, 56),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(width: 1, color: Colors.white))),
            child: const Text(
              'EXPLORE',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'SpaceGrotesk',
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const MainScreen()));
            },
          ),
        );
      },
    );
  }
}
