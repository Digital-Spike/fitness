import 'package:fitness/authentication%20screen/log_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LogoutScreen extends StatefulWidget {
  @override
  _LogoutScreenState createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Logout'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Are you sure you want to log out?',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // call the logout method from the authentication service
                Navigator.push(context,
                    MaterialPageRoute(builder: (contex) => LoginScreen()));
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
