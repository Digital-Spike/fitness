import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterCustomer extends StatefulWidget {
  const RegisterCustomer({super.key});

  @override
  State<RegisterCustomer> createState() => _RegisterCustomerState();
}

class _RegisterCustomerState extends State<RegisterCustomer> {
  List? data;
  String? name, email, phoneNumber, userId, imageUrl;

  Future<dynamic> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    String apiurl = "https://fitnessjourni.com/api/addUser.php";
    var response = await http.post(Uri.parse(apiurl),
        body: {'bookingId': prefs.getString('bookingId')});

    var jsondata = json.decode(response.body);
    print(jsondata);
    setState(() {
      name = jsondata['Name'];
      email = jsondata['email'];
      phoneNumber = jsondata['phoneNumber'];
      userId = jsondata['userId'];

      imageUrl = jsondata['ImageUrl'];
    });
  }

  void initState() {
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Customer'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Column(
              children: [
                const Text(" Image", style: TextStyle(color: Colors.black)),
                const SizedBox(
                  height: 5,
                ),
                Image.network(
                  'https://picsum.photos/250?image=9' + imageUrl.toString(),
                  fit: BoxFit.contain,
                  width: 300,
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                const SizedBox(
                    width: 180,
                    child: Text("   Name: ",
                        style: TextStyle(color: Colors.black, fontSize: 18))),
                SizedBox(
                    width: 200,
                    child: Text(name.toString(),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18)))
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(
                    width: 180,
                    child: Text("   Email: ",
                        style: TextStyle(color: Colors.black, fontSize: 18))),
                SizedBox(
                    width: 200,
                    child: Text(email.toString(),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18)))
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(
                    width: 180,
                    child: Text("   PhoneNumber: ",
                        style: TextStyle(color: Colors.black, fontSize: 18))),
                SizedBox(
                    width: 200,
                    child: Text(phoneNumber.toString(),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18)))
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(
                    width: 180,
                    child: Text("   User Id: ",
                        style: TextStyle(color: Colors.black, fontSize: 18))),
                SizedBox(
                    width: 200,
                    child: Text(userId.toString(),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18)))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
