import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';

class testlogin extends StatefulWidget {
  const testlogin({super.key});

  @override
  State<testlogin> createState() => _testloginState();
}

class _testloginState extends State<testlogin> {
  String stdname = "";
  @override
  void initState() {
    super.initState();
    assignvalues();
  }

  assignvalues() async {
    final prefs = await SharedPreferences.getInstance();
    stdname = (prefs.getString('login_status') ?? '');
    print(stdname);

    if (stdname != "yes") {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    }
    if (stdname == "yes") {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
