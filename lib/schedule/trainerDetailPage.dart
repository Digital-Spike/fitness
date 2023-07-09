import 'package:fitness/constants/api_list.dart';
import 'package:fitness/schedule/slotbooking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TrainerDetailPage extends StatefulWidget {
  final Map<String, dynamic> trainer;
  final bool isBranch;
  const TrainerDetailPage(
      {Key? key, required this.trainer, required this.isBranch})
      : super(key: key);

  @override
  State<TrainerDetailPage> createState() => _TrainerDetailPageState();
}

class _TrainerDetailPageState extends State<TrainerDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            height: 1.0,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Trainer",
          style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      SvgPicture.network(
                        ApiList.imageUrl + (widget.trainer['image'] ?? ""),
                        fit: BoxFit.cover,
                        placeholderBuilder: (BuildContext context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                      const SizedBox(height: 30),
                      Center(
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  minimumSize: const Size(400, 50),
                                  backgroundColor: Colors.deepOrange),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SlotBooking(
                                              isBranch: widget.isBranch,
                                              trainer: widget.trainer,
                                            )));
                              },
                              child: const Text(
                                'Book Your Slot Now',
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ))),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          const Expanded(
                            flex: 2,
                            child: Text(
                              'Name :',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 4,
                            child: Text(
                              widget.trainer['name'],
                              style: const TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Expanded(
                            flex: 2,
                            child: Text(
                              'Experience :',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 4,
                            child: Text(
                              widget.trainer['description'],
                              style: const TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*{
        "id": "7",
        "name": "Jeylan Silanovich",
        "phoneNumber": "0",
        "category": "None",
        "branch": "01",
        "image": "Trainer4.svg",
        "status": "ACTIVE",
        "balance": "0",
        "description": "3+ Years of experience",
        "rating": "4",
        "trainerId": "FJT01",
        "branchId1": "branch1",
        "branchId2": "branch2",
        "branchId3": "branch3",
        "branchId4": "branch4",
        "branchId5": "branch5"
    },*/
