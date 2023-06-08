import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Addbooking extends StatefulWidget {
  const Addbooking({Key? key}) : super(key: key);

  @override
  _AddbookingState createState() => _AddbookingState();
}

class _AddbookingState extends State<Addbooking> {
  final _formKey = GlobalKey<FormState>();

  Future<dynamic> bookingAdd() async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );
    try {
      final prefs = await SharedPreferences.getInstance();
      var slots = [
        '',
        '9:00 am - 9:45 am',
        '9:45 am - 10:30 am',
        '10:30 am - 11:15 am',
        '11:15 am - 12:00 pm',
        '12:00 pm - 12:45 pm',
        '2:00 pm - 2:45 pm',
        '2:45 pm - 3:30 pm',
        '3:30 pm - 4:15 pm',
        '4:15 pm - 5:00 pm',
        '5:00 pm - 5:45 pm',
        '5:45 pm - 6:30 pm',
        '6:30 pm - 7:15 pm',
        '7:15 pm - 8:00 pm'
      ];
      var bookinId = '100000000';

      String apiUrl = "https://fitnessjourni.com/api/addBooking.php";
      var response = await http.post(Uri.parse(apiUrl), body: {
        'branchId': prefs.getString('branchId'),
        'bookingId': prefs.getString('bookingId'),
        'customerId': prefs.getString('customerId'),
        'customerName': prefs.getString('customerName'),
        'trainerName': prefs.getString('trainerName'),
        'trainerId': prefs.getString('trainerId'),
        'bookingDate': prefs.getString('bookingDate'),
        'bookingTime': 'slot[a]',
        'slot': 'a',
        'amount': prefs.getString('amount'),
      });

      var jsonData = json.decode(response.body);
      if (response.statusCode == 200 && jsonData["error"] == false) {
        final snackDemo = SnackBar(
          content: Text('Booking added successfully'),
          backgroundColor: Color.fromRGBO(24, 164, 132, 1),
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(5),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackDemo);
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/home',
          (Route<dynamic> route) => false,
        );
      } else {
        final snackDemo = SnackBar(
          content: Text('Failed to add booking. Please try again later.'),
          backgroundColor: Color.fromRGBO(24, 164, 132, 1),
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(5),
        );
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 2,
        shape: const Border(
          bottom: BorderSide(
            color: Colors.grey,
          ),
        ),
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "Add Booking",
            style: TextStyle(color: Colors.green),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    backgroundColor: Color.fromRGBO(24, 164, 132, 1),
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: Text('Submit'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      bookingAdd();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
