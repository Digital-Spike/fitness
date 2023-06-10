import 'package:fitness/schedule/alvailableranches.dart';
import 'package:flutter/material.dart';

import '../schedule/gettrinerdetails.dart';
import '../schedule/slot.dart';

class MyBookingScreen extends StatefulWidget {
  const MyBookingScreen({Key? key}) : super(key: key);

  @override
  _MyBookingScreenState createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.white, // Change app bar color to white
        title: Text(
          'My Bookings',
          style: TextStyle(
            color: Colors.black, // Change text color to black
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Color(0xff3E64AF),
                elevation: 5.0,
                padding: EdgeInsets.all(20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GetTrainerDetails()),
                );
              },
              child: Column(
                children: [
                  Icon(
                    Icons.book_online,
                    color: Colors.black,
                    size: 40.0,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Current Bookings',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff3E64AF),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'View your current bookings',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Color(0xff3E64AF),
                elevation: 5.0,
                padding: EdgeInsets.all(20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SlotAvailability()),
                );
              },
              child: Column(
                children: [
                  Icon(
                    Icons.pending_actions,
                    color: Colors.black,
                    size: 40.0,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Pending Bookings',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff3E64AF),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'View your pending bookings',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
