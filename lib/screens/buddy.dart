import 'dart:convert';

import 'package:fitness/screens/packagedetail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class Buddy extends StatefulWidget {
  const Buddy({super.key});

  @override
  State<Buddy> createState() => _BuddyState();
}

class _BuddyState extends State<Buddy> {
  List<Map<String, dynamic>> plansList = [];
  Future<void>? futureData;
  final List<Gradient> gridGradients = [
    LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        colors: [ Colors.red.shade900,  Colors.red.shade200,]),
    LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        colors: [  Colors.green.shade900,Colors.green.shade200]),
    LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        colors: [  Colors.cyan.shade900,  Colors.cyan.shade200,]),
    LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        colors: [ Colors.orange.shade900,  Colors.orange.shade200,]),
    LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        colors: [ Colors.purple.shade900,  Colors.purple.shade200,]),
    LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        colors: [ Colors.yellow.shade900,  Colors.yellow.shade200,]),
    LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        colors: [ Colors.teal.shade900,  Colors.teal.shade200,]),
    LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        colors: [ Colors.pink.shade900,  Colors.pink.shade200,]),
  ];
  @override
  void initState() {
    super.initState();
    futureData = getBranchList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder<void>(
          future: futureData,
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return GridView.builder(
                itemCount: plansList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 120,
                  crossAxisCount: 2,
                ),
                itemBuilder: ((context, index) {
                  var package = plansList[index];
                  String validity = package['validity'];
                  int days = int.tryParse(validity.split(' ')[0]) ?? 0;
                  return InkWell(
                    onTap: () {
                      var selectedPackage = plansList[index];

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PackageDetail(
                            gradient: gridGradients[index],
                            price: int.parse(selectedPackage['price']),
                            session: int.parse(selectedPackage['sessions']),
                            validity: days,
                            perSession: selectedPackage['price_session'].toString(),
                          ),
                        ),
                      );

                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: gridGradients[index],
                      ),
                      child: Column(
                        children: [
                          Text(
                            package['sessions'].toString(),
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Sessions',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        ],
                      ),
                    ),
                  );
                }),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("Something went wrong"));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Future<void> getBranchList() async {
    try {
      String trainerUrl = "https://fitnessjourni.com/api/getAllPackages";
      var response = await http.post(Uri.parse(trainerUrl), body: {});

      if (response.statusCode == 200) {
        print("API Response: ${response.body}");
        List<Map<String, dynamic>> allPackages = (json.decode(response.body) as List<dynamic>)
            .map((package) => package as Map<String, dynamic>)
            .toList();

       
        plansList = allPackages
            .where((package) => package['persons'] == 'buddy')
            .toList();
      }
    } catch (e) {
      print("Error: $e");
    }

    
    setState(() {});
  }

}
