import 'package:flutter/material.dart';
import 'alvailableranches.dart';
import 'getbranchtrainers.dart';

class MyScheduleScreen extends StatefulWidget {
  const MyScheduleScreen({Key? key}) : super(key: key);

  @override
  _MyScheduleScreenState createState() => _MyScheduleScreenState();
}

class _MyScheduleScreenState extends State<MyScheduleScreen> {
  List<Slot> slots = [
    Slot(
      imageAsset: 'assets/1.png',
      title: 'EMS Fitness at Home',
      description: 'Book Your Session',
      color: Colors.blueGrey,
    ),
    Slot(
      imageAsset: 'assets/2.png',
      title: 'EMS Fitness At Gym',
      description: 'Book a Session',
      color: Colors.blueGrey,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'My Schedule',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: slots.map((slot) {
            return Container(
              margin: EdgeInsets.only(bottom: 20.0),
              decoration: BoxDecoration(
                color: slot.color,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Colors.deepOrange,
                  width: 2.0,
                ),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Color(0xff3E64AF),
                  elevation: 5.0,
                  padding: EdgeInsets.all(20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide.none,
                  ),
                ),
                onPressed: () {
                  if (slot == slots[0]) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GetTrainer(),
                      ),
                    );
                  } else if (slot == slots[1]) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AvailableBranches(),
                      ),
                    );
                  }
                },
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Image.asset(
                        slot.imageAsset,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      slot.title,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff3E64AF),
                      ),
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class Slot {
  final String imageAsset;
  final String title;
  final String description;
  final Color color;

  Slot({
    required this.imageAsset,
    required this.title,
    required this.description,
    required this.color,
  });
}
