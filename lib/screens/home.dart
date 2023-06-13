import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> carouselImages = [
    "assets/1.png",
    "assets/2.png",
    "assets/3.png",
    "assets/4.png",
  ];

  int _currentCarouselIndex = 0;
  List<String> trainersList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  List? data;
  int? total = 0;

  Future<void> fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    String? bid = prefs.getString("branch");
    String apiurl = "https://fitnessjourni.com/api/getBranchTrainers.php";
    var response = await http.post(Uri.parse(apiurl), body: {'branch': bid});

    setState(() {
      data = json.decode(response.body);
      total = data?.length;
      // trainersList =
      //     data?.map((trainer) => trainer["image"]).toList()?.cast<String>() ??
      //         [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: Icon(Icons.language),
          color: Colors.white,
          onPressed: () {
            // Handle language icon press
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/fitnessname.png',
              height: AppBar().preferredSize.height + 35, // Increase the height
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            color: Colors.white,
            onPressed: () {
              // Handle notification icon press
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Divider(
            height: 1,
            color: Colors.white,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 200.0,
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,
                      autoPlay: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentCarouselIndex = index;
                        });
                      },
                    ),
                    items: carouselImages.map((image) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 2),
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.asset(
                                image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: carouselImages.map((image) {
                      int index = carouselImages.indexOf(image);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentCarouselIndex == index
                              ? Colors.blueAccent
                              : Colors.grey,
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Select a Trainer for EMS at Home',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            offset: Offset(0, 2),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: trainersList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final trainerImage = trainersList[index];
                        return GestureDetector(
                          onTap: () {
                            // Handle trainer selection
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: Colors.grey, width: 1.5),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                'https://fitnessjourni.com/api/uploads/' +
                                    (data?[index]["image"] ?? ""),
                                // 'https://fitnessjourni.com/api/uploads/$trainerImage',
                                // fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Select a Trainer for EMS at Gym',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            offset: Offset(0, 2),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: trainersList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final trainerImage = trainersList[index];
                        return GestureDetector(
                          onTap: () {
                            // Handle trainer selection
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: Colors.grey, width: 1.5),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                'https://fitnessjourni.com/api/uploads/' +
                                    (data?[index]["image"] ?? ""),
                                // 'https://fitnessjourni.com/api/uploads/$trainerImage',
                                // fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
