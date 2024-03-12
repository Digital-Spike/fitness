import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/Calender_package/datetimeline.dart';
import 'package:fitness/constants/api_list.dart';
import 'package:fitness/my_booking/mybookings.dart';
import 'package:lottie/lottie.dart';
import 'package:fitness/screens/ourpackages.dart';
import 'package:fitness/util/string_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class SlotBookingPage extends StatefulWidget {
  final bool isBranch;
  final String trainerName;
  final String branchAddress;
  final String trainerImage;
  final String branchName;
  final String trainerRating;
  final String experience;
  final Map<String, dynamic> trainer;
  final Map<String, dynamic>? bookingData;
  final bool? isChangeSlot;
  final ChangeSlotEnum? changeSlotEnum;
  const SlotBookingPage(
      {required this.isBranch,
      required this.trainer,
      this.bookingData,
      this.isChangeSlot,
      this.changeSlotEnum,
      super.key,
      required this.trainerName,
      required this.branchAddress,
      required this.trainerImage,
      required this.trainerRating,
      required this.experience,
      required this.branchName});

  @override
  State<SlotBookingPage> createState() => _SlotBookingPageState();
}

class _SlotBookingPageState extends State<SlotBookingPage> {
  Future<bool>? futureData;
  Map<String, dynamic> slots = {};
  DateTime _selectedDay = DateTime.now();
  User? user = FirebaseAuth.instance.currentUser;

  final items = [
    'Free Trail Session',
    'Pay Per Session',
    'Single Plan Subscription',
    'Buddy Plan Subscription'
  ];
  String? value;
  final items1 = [
    'EMS Fitness Training',
    'Personal Training',
    'Injury Rehab',
    'Body Building'
  ];

  List homeTimeStamp = [
    "09:00 am - 10:30 am",
    "10:30 am - 12:00 pm",
    "12:00 pm - 01:30 pm",
    "02:00 pm - 03:30 pm",
    "03:30 pm - 05:00 pm",
    "05:00 pm - 06:30 pm",
    "06:30 pm - 08:00 pm"
  ];

  List branchTimeStamp = [
    "09:00 am - 09:45 am",
    "09:45 am - 10:30 am",
    "10:30 am - 11:15 am",
    "11:15 am - 12:00 pm",
    "12:00 pm - 12:45 pm",
    "02:00 pm - 02:45 pm",
    "02:45 pm - 03:30 pm",
    "03:30 pm - 04:15 pm",
    "04:15 pm - 05:00 pm",
    "05:00 pm - 05:45 pm",
    "05:45 pm - 06:30 pm",
    "06:30 pm - 07:15 pm",
    "07:15 pm - 08:00 pm"
  ];
  int selected = -1;
  bool isBooked = false;
  @override
  void initState() {
    futureData = slotList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 50),
              child: Text('Book Your Session',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'SpaceGrotesk',
                    fontWeight: FontWeight.w600,
                  )),
            ),
            if (widget.isBranch == true)
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            height: 1.0,
            color: const Color(0xff142129),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  minimumSize: const Size(double.infinity, 56)),
              onPressed: () {
                print(selected);
                List timeStamp =
                    widget.isBranch ? branchTimeStamp : homeTimeStamp;
                print(timeStamp[selected]);
                bool isBooked =
                    slots[(selected + 1).toString()].toString().toLowerCase() ==
                        "booked";
                if (!isBooked) {
                  if (ApiList.user?['subscriptionId'] == null ||
                      ApiList.user?['available'] == "0") {
                    showSubscriptionPopup();
                    return;
                  }
                  showBookingPopup(
                      timeStamp: timeStamp[selected],
                      index: selected,
                      isBooked: isBooked);
                }

                // if (selected >= 0) {
                //   selectedSlot(timeStamp: timeStamp[index], index: index, isBooked: isBooked);
                // } else {
                //   print('please select');
                // }
              },
              child: const Text(
                'Book Now',
                style: TextStyle(
                    fontFamily: 'SpaceGrotesk',
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              )),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 72,
                        width: 72,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: CachedNetworkImage(
                          imageUrl:
                              ApiList.imageUrl + (widget.trainerImage ?? ""),
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator.adaptive(
                              backgroundColor: Colors.white,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.trainerName,
                            style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontFamily: 'SpaceGrotesk'),
                          ),
                          const SizedBox(height: 5),
                          Column(
                            children: [
                              if (widget.trainerRating == '1')
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
                                    Text('${widget.trainerRating} Rating',
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'WorkSans'))
                                  ],
                                ),
                              if (widget.trainerRating == '2')
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
                                    Text('${widget.trainerRating} Rating',
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'WorkSans'))
                                  ],
                                ),
                              if (widget.trainerRating == '3')
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
                                    Text('${widget.trainerRating} Rating',
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'WorkSans'))
                                  ],
                                ),
                              if (widget.trainerRating == '4')
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
                                    Text('${widget.trainerRating} Rating',
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'WorkSans'))
                                  ],
                                ),
                              if (widget.trainerRating == '5')
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
                                      '${widget.trainerRating} Rating',
                                      style: const TextStyle(
                                          fontSize: 14, fontFamily: 'WorkSans'),
                                    )
                                  ],
                                ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/svg/barbell.svg'),
                                const SizedBox(width: 5),
                                Text(
                                  widget.experience
                                      .toString()
                                      .replaceAll('of experience', ''),
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
                ],
              ),
            ),
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
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
                  setState(() {
                    _selectedDay = date;
                    selected = -1;
                    futureData = slotList();
                  });
                },
              ),
            ),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'Preferred Time',
                style: TextStyle(fontSize: 14, fontFamily: 'WorkSans'),
              ),
            ),
            SizedBox(
              child: FutureBuilder<bool>(
                future: futureData,
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(10),
                        itemCount: slots.length,
                        itemBuilder: (context, index) {
                          List timeStamp =
                              widget.isBranch ? branchTimeStamp : homeTimeStamp;

                          bool isBooked = slots[(index + 1).toString()]
                                  .toString()
                                  .toLowerCase() ==
                              "booked";

                          return InkWell(
                            onTap: () {
                              print(isBooked);
                              if (!isBooked) {
                                if (ApiList.user?['subscriptionId'] == null ||
                                    ApiList.user?['available'] == "0") {
                                  showSubscriptionPopup();
                                  return;
                                }

                                showBookingPopup(
                                    timeStamp: timeStamp[index],
                                    index: index,
                                    isBooked: isBooked);
                              }
                            },
                            child: Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 15),
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          width: 1,
                                          color: const Color(0xff142129))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Transform.scale(
                                        scale: 1.3,
                                        child: Radio(
                                            fillColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) => isBooked
                                                        ? const Color(
                                                            0xffB3BAC3)
                                                        : Colors.white),
                                            activeColor: isBooked
                                                ? const Color(0xffB3BAC3)
                                                : Colors.white,
                                            value: index,
                                            groupValue: selected,
                                            onChanged: (value) {
                                              setState(() {
                                                if (isBooked == true)
                                                  value = -1;

                                                selected = value!;
                                              });
                                            }),
                                      ),
                                      Text(
                                        timeStamp[index]
                                            .toString()
                                            .toUpperCase(),
                                        style: TextStyle(
                                            color: isBooked
                                                ? const Color(0xffB3BAC3)
                                                : Colors.white,
                                            fontSize: 18,
                                            fontFamily: 'SpaceGrotesk',
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(width: 10),
                                      const SizedBox(width: 10),
                                      const SizedBox(width: 10),
                                    ],
                                  ),
                                ),
                                isBooked
                                    ? Positioned(
                                        top: 5,
                                        right: 10,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 1),
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(5),
                                                  topRight: Radius.circular(5)),
                                              color: Color(0xffFD7278)),
                                          child: const Text(
                                            "BOOKED",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'WorkSans',
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                          ),
                                        ))
                                    : const SizedBox()
                              ],
                            ),
                          );
                        });
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
      ),
    );
  }

  void selectedSlot(
      {required String timeStamp, required int index, required bool isBooked}) {
    if (!isBooked) {
      if (ApiList.user?['subscriptionId'] == null ||
          ApiList.user?['available'] == "0") {
        showSubscriptionPopup();
        return;
      }

      showBookingPopup(
          timeStamp: timeStamp[index], index: index, isBooked: isBooked);
    }
  }

  Future<bool> slotList() async {
    try {
      http.Response? response;
      if (widget.isBranch) {
        String trainerUrl = "${ApiList.apiUrl}slotavailability.php";
        response = await http.post(Uri.parse(trainerUrl), body: {
          'trainerId': widget.trainer['trainerId'],
          'bookingDate': DateFormat('yyyy/MM/dd').format(_selectedDay)
        });
      } else {
        String trainerUrl = "${ApiList.apiUrl}webslothome.php";
        response = await http.post(Uri.parse(trainerUrl), body: {
          'trainerId': widget.trainer['trainerId'],
          'bdate': DateFormat('yyyy/MM/dd').format(_selectedDay)
        });
      }
      slots = json.decode(response.body);
      if (DateFormat('yyyy/MM/dd').format(_selectedDay) ==
          DateFormat("yyyy/MM/dd").format(DateTime.now())) {
        List branchTimeStamp1 = [
          '08:45AM',
          '09:30AM',
          '10:15AM',
          '11:00AM',
          '11:45AM',
          '01:45PM',
          '02:30PM',
          '03:15PM',
          '04:00PM',
          '04:45PM',
          '05:30PM',
          '06:15PM',
          '07:00PM'
        ];
        List homeTimeStamp1 = [
          "08:30AM",
          "10:00AM",
          "11:30AM",
          "01:30PM",
          "03:00PM",
          "04:30PM",
          "06:00PM"
        ];
        List timeStamp1 = widget.isBranch ? branchTimeStamp1 : homeTimeStamp1;
        for (int i = 0; i < timeStamp1.length; i++) {
          var df = DateFormat("h:mma");
          var dt = df.parse(timeStamp1[i]);

          String currentDate = DateFormat("yyyy-MM-dd").format(DateTime.now());

          final dt3 =
              DateTime.parse("$currentDate ${DateFormat('HH:mm').format(dt)}");

          var datetime = DateTime.now();

          if (dt3.isAfter(datetime)) {
          } else {
            slots[(i + 1).toString()] = "booked";
          }
        }
      } else {
        slots = json.decode(response.body);
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
      );
  DropdownMenuItem<String> buildMenuItem1(String item1) => DropdownMenuItem(
        value: item1,
        child: Text(
          item1,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
      );

  Future<void> showBookingPopup(
      {required String timeStamp,
      required int index,
      required bool isBooked}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Book Slot? Are you sure?',
            style: TextStyle(
              fontFamily: 'SpaceGrotesk',
              color: Colors.white,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          content: Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      onPressed: () async {
                        if (!(widget.isChangeSlot ?? false) && isBooked) {
                          return;
                        }
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return Dialog(
                              backgroundColor: Colors.transparent,
                              child: Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Lottie.asset(
                                      'assets/json/fjloader.json',
                                      height: 100)),
                            );
                          },
                        );
                        if (widget.isChangeSlot ?? false) {
                          await changeSlotFuture(
                              bookingTime: timeStamp,
                              slotNumber: (index + 1).toString());
                        } else if (!isBooked) {
                          await bookSession(
                              bookingTime: timeStamp,
                              slotNumber: (index + 1).toString());
                        }
                        if (mounted) {
                          Navigator.of(context).pop();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const MyBookingPage()));
                        }
                        setState(() {
                          futureData = slotList();
                        });
                      },
                      child: const Text(
                        'YES',
                        style: TextStyle(
                            fontFamily: 'SpaceGrotesk',
                            fontSize: 16,
                            color: Colors.black),
                      ))),
              const SizedBox(width: 15),
              Expanded(
                child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('NO',
                        style: TextStyle(
                            fontFamily: 'SpaceGrotesk',
                            fontSize: 16,
                            color: Colors.white))),
              )
            ],
          ),
        );
      },
    );
  }

  showSubscriptionPopup() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(width: 1, color: Colors.white)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          title: const Text(
            'There is no active subscription plan, please select a subscription plan.',
            style: TextStyle(
              fontFamily: 'SpaceGrotesk',
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          content: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          minimumSize: const Size(154, 56)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Back',
                        style: TextStyle(
                            fontFamily: 'SpaceGrotesk',
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      )),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          minimumSize: const Size(154, 56)),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const OurPackages(
                                      initialtab: 0,
                                    )));
                      },
                      child: const Text('Subscribe',
                          style: TextStyle(
                              fontFamily: 'SpaceGrotesk',
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w600))),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<bool> bookSession({
    required String slotNumber,
    required String bookingTime,
  }) async {
    try {
      Map<String, dynamic> requestBody = {
        'trainerId': widget.trainer['trainerId'],
        'bookingDate': DateFormat('yyyy/MM/dd').format(_selectedDay),
        'branchName': widget.branchName,
        'bookingId': StringUtil().generateRandomNumber(length: 10),
        'customerId': user?.uid,
        'customerName': /*ApiList.user?['name']*/
            user?.displayName ?? ApiList.user?['name'],
        'trainerName': widget.trainer['name'],
        'bookingTime': bookingTime,
        'slot': slotNumber,
        'amount': '500'
      };

      String trainerUrl = widget.isBranch
          ? "${ApiList.apiUrl}addBooking.php"
          : "${ApiList.apiUrl}homeaddBooking.php";
      jsonEncode(requestBody);
      await http.post(Uri.parse(trainerUrl), body: requestBody);
      return true;
    } catch (e) {
      return false;
    }
  }

  changeSlotFuture(
      {required String bookingTime, required String slotNumber}) async {
    try {
      Map<String, dynamic> requestBody = {
        'bookingDate': DateFormat('yyyy/MM/dd').format(_selectedDay),
        'bookingId': widget.bookingData?["bookingId"],
        'bookingTime': bookingTime,
        'slot': slotNumber,
      };

      String changeSlot = "${ApiList.apiUrl}updateBooking.php";
      await http.post(Uri.parse(changeSlot), body: requestBody);
      return true;
    } catch (e) {
      return false;
    }
  }
}
