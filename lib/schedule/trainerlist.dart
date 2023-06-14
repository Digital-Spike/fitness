import 'package:fitness/schedule/slotbooking.dart';
import 'package:flutter/material.dart';

class TrainerList extends StatefulWidget {
  const TrainerList({super.key});

  @override
  State<TrainerList> createState() => _TrainerListState();
}

class _TrainerListState extends State<TrainerList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            height: 1.0,
            color: Colors.white,
          ),
        ),
        title: const Text('Available Trainers',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SlotBooking(),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      padding: EdgeInsets.all(16),
                      height: 150,
                      width: 350,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: ListTile(
                        leading: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(150),
                              border: Border.all(color: Colors.black)),
                          child: CircleAvatar(
                            radius: 80,
                          ),
                        ),
                        title: Text(
                          "Name:",
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 18, // Increase the font size as needed
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Experience: ",
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black87,
                                fontSize:
                                    18, // Increase the font size as needed
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Skills: ",
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black87,
                                fontSize:
                                    18, // Increase the font size as needed
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
