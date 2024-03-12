import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:fitness/Calender_package/datetimeline.dart';
import 'package:fitness/my_booking/slotBookingPage.dart';
import 'package:fitness/constants/api_list.dart';
import 'package:fitness/trainerscreens/triner_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class TrainerList extends StatefulWidget {
  final bool isBranchTrainers;
  final String? branchId;
  final bool? isOurTrainers;
  final String branchName;
  final String branchAddress;
  const TrainerList(
      {required this.isBranchTrainers,
      this.branchId,
      this.isOurTrainers,
      super.key,
      required this.branchName,
      required this.branchAddress});

  @override
  State<TrainerList> createState() => _TrainerListState();
}

class _TrainerListState extends State<TrainerList> {
  DateTime _selectedDay = DateTime.now();
  List trainersList = [];
  Future<bool>? futureData;

  @override
  void initState() {
    futureData = trainerList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            height: 1.0,
            color: Color(0xff142129),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text(widget.branchName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'SpaceGrotesk',
                    fontWeight: FontWeight.w600,
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset('assets/svg/marker.svg'),
                const SizedBox(width: 3),
                Expanded(
                  child: Text(
                    widget.branchAddress.replaceAll('\n', ' '),
                    style:
                        const TextStyle(fontSize: 13, fontFamily: 'WorkSans'),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            )
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  formatDate(_selectedDay, [M]).toUpperCase(),
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'WorkSans'),
                ),
                const SizedBox(width: 5),
                Text(formatDate(_selectedDay, [yyyy]).toUpperCase(),
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'WorkSans')),
                SvgPicture.asset(
                  'assets/svg/arroworange.svg',
                  height: 25,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: DatePicker(
              DateTime.now(),
              initialSelectedDate: DateTime.now(),
              dateTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w700),
              dayTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
              onDateChange: (date) {
                // New date selected
                setState(() {
                  _selectedDay = date;

                  // _selectedValue = date;
                  print(date);
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              height: 1,
              width: double.infinity,
              color: Color(0xff142129),
            ),
          ),
          Expanded(
            child: FutureBuilder<bool>(
              future: futureData,
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                    itemCount: trainersList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            (widget.isOurTrainers ?? false)
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TrainerProfile(
                                            trainer: trainersList[index])))
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SlotBookingPage(
                                              isBranch: widget.isBranchTrainers,
                                              trainer: trainersList[index],
                                              trainerName: trainersList[index]
                                                  ['name'],
                                              branchAddress:
                                                  widget.branchAddress,
                                              trainerImage: trainersList[index]
                                                  ['image'],
                                              trainerRating: trainersList[index]
                                                  ['rating'],
                                              experience: trainersList[index]
                                                  ['description'], branchName: widget.branchName,
                                            )));
                          },
                          child: Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 1,
                                        color: const Color(0xff142129))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 72,
                                      width: 72,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: CachedNetworkImage(
                                        imageUrl: ApiList.imageUrl +
                                            (trainersList[index]['image'] ??
                                                ""),
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator
                                                .adaptive(
                                          backgroundColor: Colors.white,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          trainersList[index]['name'],
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                              fontFamily: 'SpaceGrotesk'),
                                        ),
                                        const SizedBox(height: 5),
                                        Column(
                                          children: [
                                            if (trainersList[index]['rating'] ==
                                                '1')
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.star,
                                                    color: Color(0xffFF6600),
                                                    size: 20,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Icon(
                                                    Icons.star_border_outlined,
                                                    color: Color(0xffFF6600),
                                                    size: 20,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Icon(
                                                    Icons.star_border_outlined,
                                                    color: Color(0xffFF6600),
                                                    size: 20,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Icon(
                                                    Icons.star_border_outlined,
                                                    color: Color(0xffFF6600),
                                                    size: 20,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Icon(
                                                    Icons.star_border_outlined,
                                                    color: Color(0xffFF6600),
                                                    size: 20,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                      trainersList[index]
                                                              ['rating'] +
                                                          ' Rating',
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontFamily:
                                                              'WorkSans'))
                                                ],
                                              ),
                                            if (trainersList[index]['rating'] ==
                                                '2')
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.star,
                                                    color: Color(0xffFF6600),
                                                    size: 20,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Icon(
                                                    Icons.star,
                                                    color: Color(0xffFF6600),
                                                    size: 20,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Icon(
                                                    Icons.star_border_outlined,
                                                    color: Color(0xffFF6600),
                                                    size: 20,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Icon(
                                                    Icons.star_border_outlined,
                                                    color: Color(0xffFF6600),
                                                    size: 20,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Icon(
                                                    Icons.star_border_outlined,
                                                    color: Color(0xffFF6600),
                                                    size: 20,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                      trainersList[index]
                                                              ['rating'] +
                                                          ' Rating',
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontFamily:
                                                              'WorkSans'))
                                                ],
                                              ),
                                            if (trainersList[index]['rating'] ==
                                                '3')
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.star,
                                                    color: Color(0xffFF6600),
                                                    size: 20,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Icon(
                                                    Icons.star,
                                                    color: Color(0xffFF6600),
                                                    size: 20,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Icon(
                                                    Icons.star,
                                                    color: Color(0xffFF6600),
                                                    size: 20,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Icon(
                                                    Icons.star_border_outlined,
                                                    color: Color(0xffFF6600),
                                                    size: 20,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Icon(
                                                    Icons.star_border_outlined,
                                                    color: Color(0xffFF6600),
                                                    size: 20,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                      trainersList[index]
                                                              ['rating'] +
                                                          ' Rating',
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontFamily:
                                                              'WorkSans'))
                                                ],
                                              ),
                                            if (trainersList[index]['rating'] ==
                                                '4')
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.star,
                                                    color: Color(0xffFF6600),
                                                    size: 20,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Icon(
                                                    Icons.star,
                                                    color: Color(0xffFF6600),
                                                    size: 20,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Icon(
                                                    Icons.star,
                                                    color: Color(0xffFF6600),
                                                    size: 20,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Icon(
                                                    Icons.star,
                                                    color: Color(0xffFF6600),
                                                    size: 20,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Icon(
                                                    Icons.star_border_outlined,
                                                    color: Color(0xffFF6600),
                                                    size: 20,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                      trainersList[index]
                                                              ['rating'] +
                                                          ' Rating',
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontFamily:
                                                              'WorkSans'))
                                                ],
                                              ),
                                            if (trainersList[index]['rating'] ==
                                                '5')
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.star,
                                                    color: Color(0xffFF6600),
                                                    size: 20,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Icon(
                                                    Icons.star,
                                                    color: Color(0xffFF6600),
                                                    size: 20,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Icon(
                                                    Icons.star,
                                                    color: Color(0xffFF6600),
                                                    size: 20,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Icon(
                                                    Icons.star,
                                                    color: Color(0xffFF6600),
                                                    size: 20,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Icon(
                                                    Icons.star,
                                                    color: Color(0xffFF6600),
                                                    size: 20,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                    trainersList[index]
                                                            ['rating'] +
                                                        ' Rating',
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: 'WorkSans'),
                                                  )
                                                ],
                                              ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2, horizontal: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Colors.white),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                  'assets/svg/barbell.svg'),
                                              const SizedBox(width: 5),
                                              Text(
                                                trainersList[index]
                                                        ['description']
                                                    .toString()
                                                    .replaceAll(
                                                        'of experience', ''),
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    fontFamily: 'WorkSans'),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                  top: 15,
                                  right: 25,
                                  child: Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.circle_fill,
                                        color: (trainersList[index]['status'] ==
                                                "ACTIVE")
                                            ? const Color(0xff74C76A)
                                            : const Color(0xffFD7278),
                                        size: 10,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        (trainersList[index]['status'] ==
                                                "ACTIVE")
                                            ? 'Available'
                                            : 'Not Available',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            fontFamily: 'WorkSans',
                                            color: (trainersList[index]
                                                        ['status'] ==
                                                    "ACTIVE")
                                                ? const Color(0xff74C76A)
                                                : const Color(0xffFD7278)),
                                      ),
                                    ],
                                  )),
                              Positioned(
                                  bottom: 20,
                                  right: 25,
                                  child: Container(
                                    padding: const EdgeInsets.all(7),
                                    width: 56,
                                    height: 32,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                            width: 1, color: Colors.white)),
                                    child: SvgPicture.asset(
                                        'assets/svg/fjarrow.svg'),
                                  ))
                            ],
                          ));
                    },
                  );
                }

                if (snapshot.hasError) {
                  const Text("Something wrong");
                }

                return const Center(
                    child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.white,
                ));
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> trainerList() async {
    try {
      Response? response;
      if (widget.isBranchTrainers) {
        String trainerUrl = "${ApiList.apiUrl}getBranchTrainers.php";
        response = await http
            .post(Uri.parse(trainerUrl), body: {'branch': widget.branchId});
      } else {
        String trainerUrl = "${ApiList.apiUrl}getAllTrainers.php";
        response = await http.post(Uri.parse(trainerUrl), body: {});
      }

      trainersList = json.decode(response.body);
      return true;
    } catch (e) {
      return false;
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
}
