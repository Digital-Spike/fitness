import 'dart:async';
import 'dart:convert';
import 'package:fitness/schedule/slot.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_icon/animated_icon.dart';

class GetTrainerDetails extends StatefulWidget {
  const GetTrainerDetails({Key? key}) : super(key: key);

  @override
  State<GetTrainerDetails> createState() => _GetTrainerDetailsState();
}

class _GetTrainerDetailsState extends State<GetTrainerDetails>
    with SingleTickerProviderStateMixin {
  bool _showCircle = true;
  bool _isMenuOpen = false;
  late AnimationController _animationController;
  late Animation<Color?> _buttonColor;
  late Animation<double> _animateIcon;
  final Duration _duration = Duration(milliseconds: 500);

  List? data;
  int? total = 0;

  Future<String> getData() async {
    final prefs = await SharedPreferences.getInstance();
    String? trainerId = await prefs.getString("branch");
    String apiurl = "https://fitnessjourni.com/api/getTrainer.php";
    var response =
        await http.post(Uri.parse(apiurl), body: {'branch': trainerId});

    setState(() {
      data = json.decode(response.body);
      total = data?.length;
    });
    _showCircle = false;

    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    _showCircle = true;
    _animationController =
        AnimationController(vsync: this, duration: _duration);
    _animateIcon = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _buttonColor = ColorTween(
      begin: Colors.deepOrange,
      end: Colors.red,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );
    getData();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void animate() {
    if (!_isMenuOpen) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    _isMenuOpen = !_isMenuOpen;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        shape: const Border(
          bottom: BorderSide(
            color: Colors.grey,
          ),
        ),
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "Available Trainers ",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: _showCircle
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: data == null ? 0 : data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      bool isAvailable = data?[index]["available"] ?? false;
                      Color availabilityColor =
                          isAvailable ? Colors.green : Colors.red;

                      return InkWell(
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setString('trainer', data?[index]["trainerId"]);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SlotAvailability(),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 40, // Adjust the radius as needed
                              backgroundImage: NetworkImage(
                                'https://fitnessjourni.com/api/uploads/' +
                                    (data?[index]["image"] ?? ""),
                              ),
                            ),
                            title: Text(
                              data?[index]["name"] ?? "",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepOrange,
                                fontSize:
                                    20, // Increase the font size as needed
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Experience: " +
                                      (data?[index]["experience"] ?? ""),
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize:
                                        16, // Increase the font size as needed
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Skills: " + (data?[index]["skills"] ?? ""),
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize:
                                        14, // Increase the font size as needed
                                  ),
                                ),
                                SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
