import 'package:flutter/material.dart';
import 'package:fitness/authentication%20screen/log_in.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: 50),
              Container(
                height: 180,
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Transform your body and mind',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'with the ultimate EMS fitness journey app for anyone who wants to take control of their health and fitness',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 350),
              Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Implement sign up with Apple
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    ),
                    icon: Image.asset(
                      'assets/icons/blue.png',
                      height: 20,
                      width: 20,
                    ),
                    label: Text('Sign up with Apple'),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement regular sign up
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      onPrimary: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    ),
                    child: Text('Sign up'),
                  ),
                ],
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  primary: Colors.white,
                ),
                child: Text(
                  'Already have an account? Login',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
