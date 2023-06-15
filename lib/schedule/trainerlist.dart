import 'package:fitness/schedule/selecttrainers.dart';
import 'package:fitness/schedule/slotbooking.dart';
import 'package:fitness/schedule/trainer_card.dart';
import 'package:fitness/schedule/trainerprofile.dart';
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
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TrainerProfile()));
                    },
                    child: TrainerCard1(
                      trainerName: 'Name:',
                      experience: 'Experience:',
                      skills: 'Skills:',
                      imagepath: 'assets/Metrofit.png',
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
