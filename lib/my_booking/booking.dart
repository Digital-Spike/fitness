// import 'dart:convert';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fitness/Slotscreens/slotBookingPage.dart';
// import 'package:fitness/constants/api_list.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:http/http.dart' as http;

// class Booking extends StatefulWidget {
//   const Booking({super.key});

//   @override
//   State<Booking> createState() => _BookingState();
// }

// class _BookingState extends State<Booking> {
//   Future<bool>? futureData;
//   List bookingData = [];
//   User? user = FirebaseAuth.instance.currentUser;

//   @override
//   void initState() {
//     futureData = fetchData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         // backgroundColor: Color(0xffF5E6C2),
//         body: FutureBuilder<bool>(
//             future: futureData,
//             builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 return Padding(
//                   padding: const EdgeInsets.all(15),
//                   child: Container(
//                     // color: Colors.white,
//                     child: (bookingData.isEmpty)
//                         ? Center(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 SvgPicture.asset('assets/svg/fjsearch.svg'),
//                                 const Text(
//                                   "No Bookings found!",
//                                   style: TextStyle(
//                                       fontFamily: 'SpaceGrotesk',
//                                       fontSize: 24,
//                                       fontWeight: FontWeight.w600,
//                                       color: Color(0xffB3BAC3)),
//                                 ),
//                               ],
//                             ),
//                           )
//                         : ListView.builder(
//                             itemCount: bookingData.length,
//                             itemBuilder: ((context, index) {
//                               return Container(
//                                 padding: const EdgeInsets.all(10),
//                                 margin: const EdgeInsets.all(5),
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     color: Colors.white12),
//                                 child: Column(
//                                   children: [
//                                     Row(
//                                       children: [
//                                         const Text(
//                                           'Trainer :',
//                                           style: TextStyle(
//                                             fontSize: 15,
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                         ),
//                                         Text(
//                                           ' ${bookingData[index]?['trainerName']}',
//                                           style: const TextStyle(
//                                               color: Colors.orange,
//                                               fontSize: 15,
//                                               fontWeight: FontWeight.bold),
//                                         )
//                                       ],
//                                     ),
//                                     const SizedBox(height: 5),
//                                     Row(
//                                       children: [
//                                         const Text(
//                                           'Booking Id :',
//                                           style: TextStyle(
//                                             fontSize: 14,
//                                           ),
//                                         ),
//                                         Text(
//                                           ' ${bookingData[index]?['bookingId']}',
//                                           style: const TextStyle(
//                                             fontSize: 14,
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                     const SizedBox(height: 5),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             const Text(
//                                               'Date :',
//                                               style: TextStyle(
//                                                 fontSize: 14,
//                                               ),
//                                             ),
//                                             Container(
//                                               padding: const EdgeInsets.all(4),
//                                               decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.circular(5),
//                                                   color: Colors.white,
//                                                   border: Border.all(
//                                                       width: 1.0,
//                                                       color: Colors.black)),
//                                               child: Text(
//                                                 ' ${bookingData[index]?['bookingDate']}',
//                                                 style: const TextStyle(
//                                                     fontSize: 13,
//                                                     color: Colors.black),
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                         Row(
//                                           children: [
//                                             const Text(
//                                               'Time :',
//                                               style: TextStyle(
//                                                 fontSize: 14,
//                                               ),
//                                             ),
//                                             Container(
//                                               padding: const EdgeInsets.all(4),
//                                               decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.circular(5),
//                                                   color: Colors.white,
//                                                   border: Border.all(
//                                                       width: 1.0,
//                                                       color: Colors.black)),
//                                               child: Text(
//                                                 ' ${bookingData[index]?['bookingTime']}',
//                                                 style: const TextStyle(
//                                                     fontSize: 13,
//                                                     color: Colors.black),
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(height: 5),
//                                     Row(
//                                       children: [
//                                         const Text(
//                                           'Branch :',
//                                           style: TextStyle(
//                                             fontSize: 14,
//                                           ),
//                                         ),
//                                         Text(
//                                           ' ${bookingData[index]?['branchName']}',
//                                           style: const TextStyle(
//                                             fontSize: 14,
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       height: 5,
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceAround,
//                                       children: [
//                                         MaterialButton(
//                                             onPressed: () {
//                                               changeSlot(
//                                                   changeSlotEnum:
//                                                       ChangeSlotEnum.postpone,
//                                                   booking: bookingData[index]);
//                                             },
//                                             color: Colors.white30,
//                                             child: const Text(
//                                               'Postpone',
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 15),
//                                             )),
//                                         MaterialButton(
//                                             onPressed: () {
//                                               setState(() {});
//                                               changeSlot(
//                                                   changeSlotEnum:
//                                                       ChangeSlotEnum.prepone,
//                                                   booking: bookingData[index]);
//                                             },
//                                             color: Colors.white30,
//                                             child: const Text(
//                                               'Prepone',
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 15),
//                                             )),
//                                         MaterialButton(
//                                             onPressed: () {
//                                               cancelBooking(
//                                                   bookingId: bookingData[index]
//                                                       ?['bookingId']);
//                                             },
//                                             color: Colors.white30,
//                                             child: const Text(
//                                               'Cancel',
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 15),
//                                             ))
//                                       ],
//                                     ),
//                                     const SizedBox(height: 5),
//                                     const Divider(
//                                       height: 1.0,
//                                       thickness: 1.0,
//                                       color: Colors.black,
//                                     ),
//                                     const SizedBox(height: 5),
//                                     const Text(
//                                       'You can update your session within 12 hours of booking',
//                                       textAlign: TextAlign.center,
//                                     )
//                                   ],
//                                 ),
//                               );
//                             })),
//                   ),
//                 );
//               }

//               if (snapshot.hasError) {
//                 const Text("Something wrong");
//               }

//               return const Center(child: CircularProgressIndicator());
//             }));
//   }

//   Future<bool> fetchData() async {
//     try {
//       String trainerUrl = "${ApiList.apiUrl}getUserBookings.php";
//       var response =
//           await http.post(Uri.parse(trainerUrl), body: {'userId': user?.uid});
//       bookingData = json.decode(response.body);

//       bookingData.retainWhere((element) => element['status'] == "PENDING");

//       Set<String> seenIds = {};
//       List<Map<String, dynamic>> uniqueList = [];

//       for (var item in bookingData) {
//         String id = item['bookingId'];
//         if (!seenIds.contains(id)) {
//           seenIds.add(id);
//           uniqueList.add(item);
//         }
//       }
//       bookingData = uniqueList;

//       return true;
//     } catch (e) {
//       setState(() {
//         bookingData.clear();
//       });
//       return false;
//     }
//   }

//   void changeSlot(
//       {required ChangeSlotEnum changeSlotEnum, required var booking}) async {
//     Map<String, dynamic> trainer = {};
//     try {
//       String trainerUrl = "${ApiList.apiUrl}admin/viewTrainer.php";
//       var response = await http.post(Uri.parse(trainerUrl),
//           body: {'trainerId': booking['trainerId']});
//       trainer = json.decode(response.body);
//     } catch (e) {}

//     if (!mounted) {
//       return;
//     }

//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => SlotBookingPage(
//           isBranch: booking?['branchName'].toString().toLowerCase() != 'home',
//           bookingData: booking,
//           trainer: trainer,
//           changeSlotEnum: changeSlotEnum,
//           isChangeSlot: true,
//           trainerName: '',
//           branchAddress: '',
//           trainerImage: '',
//           trainerRating: '',
//           experience: '',
//         ),
//       ),
//     );
//   }

//   void cancelBooking({required String bookingId}) async {
//     try {
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return const Dialog(
//             child: Padding(
//               padding: EdgeInsets.all(20.0),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   CircularProgressIndicator(),
//                   Padding(
//                     padding: EdgeInsets.only(left: 4.0),
//                     child: Text("Processing..."),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       );
//       String trainerUrl = "${ApiList.apiUrl}cancelBooking.php";
//       await http.post(Uri.parse(trainerUrl),
//           body: {'bookingId': bookingId, 'userId': user?.uid});
//     } catch (e) {}
//     Navigator.of(context).pop();
//     futureData = fetchData();
//   }
// }

// enum ChangeSlotEnum { postpone, prepone, cancel }
