import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/constants/api_list.dart';
import 'package:fitness/my_booking/slotBookingPage.dart';
import 'package:flutter/material.dart';

class TrainerDetail extends StatefulWidget {
  final Map<String, dynamic> trainer;
  final bool isBranch;
  const TrainerDetail(
      {super.key, required this.trainer, required this.isBranch});

  @override
  State<TrainerDetail> createState() => _TrainerProfileState();
}

class _TrainerProfileState extends State<TrainerDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5E6C2),
      appBar: AppBar(
        backgroundColor: const Color(0xffF5E6C2),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            height: 1.0,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Trainer Profile', // call Trainer name from api
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w900, color: Colors.black),
        ),
        centerTitle: true,
        leading: const BackButton(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  CircleAvatar(
                    minRadius: 60,
                    backgroundColor: Colors.grey,
                    child: CachedNetworkImage(
                      height: 120,
                      imageUrl:
                          ApiList.imageUrl + (widget.trainer['image'] ?? ""),
                      placeholder: (context, url) => Container(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.trainer['name'],
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.deepOrange),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: const LinearGradient(
                                      colors: [Colors.blue, Colors.purple])),
                              child: const Text(
                                'EMS Trainer',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              )),
                          Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: const LinearGradient(
                                      colors: [Colors.blue, Colors.purple])),
                              child: const Text(
                                'Body Building',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: const LinearGradient(
                                      colors: [Colors.blue, Colors.purple])),
                              child: const Text(
                                'Arabic',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              )),
                          Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: const LinearGradient(
                                      colors: [Colors.blue, Colors.purple])),
                              child: const Text(
                                'English',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              )),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Divider(
              height: 1.0,
              thickness: 1.0,
              color: Colors.black,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Description',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                  Text(widget.trainer['description'])
                ],
              ),
            ),
           /* Center(
                child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SlotBookingPage(
                              isBranch: widget.isBranch,
                              trainer: widget.trainer,
                            )));
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                height: 40,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                        colors: [Colors.green, Colors.blue])),
                child: const Text(
                  'Book Session',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ))*/
          ],
        ),
      ),
    );
  }
}
