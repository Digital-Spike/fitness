import 'package:fitness/screens/buddy.dart';
import 'package:fitness/screens/main_screen.dart';

import 'package:fitness/screens/single.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

class Packages extends StatefulWidget {
  const Packages({super.key});

  @override
  State<Packages> createState() => _MyBookingPageState();
}

class _MyBookingPageState extends State<Packages>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? selectedplans;

  List<int> session = [];
  List<int> price = [];
  List<int> validity = [];
  List<String> perSession = [];

  List<int> singleStandardSession = [2, 4, 8, 12, 24, 48, 96];
  List<int> singleStandardPrice = [359, 652, 1248, 1788, 3096, 4800, 7599];
  List<String> singleStandardPerSession = [
    "169",
    "163",
    "156",
    "149",
    "129",
    "100",
    "79"
  ];
  List<int> singleStandardValidity = [15, 15, 30, 30, 60, 120, 365];

  List<int> singleSpecialSession = [24, 48, 96];
  List<int> singleSpecialPrice = [2786, 4320, 6839];
  List<int> singleSpecialValidity = [90, 180, 365];
  List<String> singleSpecialPerSession = ['NA', 'NA', 'NA'];

  List<int> buddyStandardSession = [2, 4, 8, 12, 24, 48, 96];
  List<int> buddyStandardPrice = [398, 796, 1552, 2328, 4296, 6240, 9600];
  List<String> buddyStandardPerSession = [
    "199",
    "199",
    "194",
    "194",
    "179",
    "130",
    "100"
  ];
  List<int> buddyStandardValidity = [15, 30, 60, 90, 160, 180, 365];

  List<int> buddySpecialSession = [24, 48, 96];
  List<int> buddySpecialPrice = [3866, 5616, 8640];
  List<int> buddySpecialValidity = [90, 180, 365];
  List<String> buddySpecialPerSession = ['NA', 'NA', 'NA'];

  int _selectedValidity = 0;
  int _selectedSession = 0;
  int _selectedPrice = 0;
  int _selectedPerSession = 0;

  final List<String> options = ['Standard', 'Special'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    session = singleStandardSession;
    price = singleStandardPrice;
    validity = singleStandardValidity;
    perSession = singleStandardPerSession;
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {});
  }

  final List<Gradient> gridGradients = [
    LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        colors: [
          Colors.red.shade900,
          Colors.red.shade200,
        ]),
    LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        colors: [Colors.green.shade900, Colors.green.shade200]),
    LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        colors: [
          Colors.cyan.shade900,
          Colors.cyan.shade200,
        ]),
    LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        colors: [
          Colors.orange.shade900,
          Colors.orange.shade200,
        ]),
    LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        colors: [
          Colors.purple.shade900,
          Colors.purple.shade200,
        ]),
    LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        colors: [
          Colors.yellow.shade900,
          Colors.yellow.shade200,
        ]),
    LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        colors: [
          Colors.teal.shade900,
          Colors.teal.shade200,
        ]),
    LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        colors: [
          Colors.pink.shade900,
          Colors.pink.shade200,
        ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //  backgroundColor: const Color(0xffF5E6C2),
        elevation: 0,

        title: const Text(
          'Our Packages',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          },
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.grey.shade800, Colors.black54])),
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(10),
            //   child: DropdownButtonFormField<String>(
            //     value: selectedplans,
            //     items: options.map((String option) {
            //       return DropdownMenuItem<String>(
            //         value: option,
            //         child: Text(option),
            //       );
            //     }).toList(),
            //     onChanged: (value) {
            //       setState(() {
            //         selectedplans = value!;
            //         setState(() {
            //           if (selectedplans == 'Standard') {
            //             if (_tabController.index == 0) {
            //               session = singleStandardSession;
            //               price = singleStandardPrice;
            //               validity = singleStandardValidity;
            //               perSession = singleStandardPerSession;
            //             } else {
            //               session = buddyStandardSession;
            //               price = buddyStandardPrice;
            //               validity = buddyStandardValidity;
            //               perSession = buddyStandardPerSession;
            //             }
            //           } else {
            //             if (_tabController.index == 0) {
            //               session = singleSpecialSession;
            //               price = singleSpecialPrice;
            //               validity = singleSpecialValidity;
            //               perSession = singleSpecialPerSession;
            //             } else {
            //               session = buddySpecialSession;
            //               price = buddySpecialPrice;
            //               validity = buddySpecialValidity;
            //               perSession = buddySpecialPerSession;
            //             }
            //           }
            //         });
            //       });
            //     },
            //     validator: (value) {
            //       if (value == null) {
            //         return 'Please select an option';
            //       }
            //       return null;
            //     },
            //     decoration: InputDecoration(
            //       isDense: true,
            //       // labelText: 'Select a plan',
            //       hintText: 'Select a plan',
            //       border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(10)),
            //     ),
            //   ),
            // ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white54,
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors
                      .deepOrange, // Set the indicator color to deep orange
                ),
                tabs: [
                  Tab(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Single',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: _tabController.index == 0
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Buddy',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: _tabController.index == 1
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.black, // Set background color to black
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    Single(), Buddy()
                    // Padding(
                    //   padding: const EdgeInsets.all(10),
                    //   child: GridView.builder(
                    //       itemCount: session.length,
                    //       gridDelegate:
                    //           const SliverGridDelegateWithFixedCrossAxisCount(
                    //               mainAxisExtent: 120, crossAxisCount: 2),
                    //       itemBuilder: ((context, index) {
                    //         return InkWell(
                    //           onTap: () {
                    //             setState(() {
                    //               _selectedPerSession = index;
                    //               _selectedPrice = index;
                    //               _selectedSession = index;
                    //               _selectedValidity = index;
                    //             });
                    //             Navigator.push(
                    //                 context,
                    //                 MaterialPageRoute(
                    //                     builder: (context) => PackageDetail(
                    //                           gradient: gridGradients[index],
                    //                           perSession: perSession[
                    //                               _selectedPerSession],
                    //                           price: price[_selectedPrice],
                    //                           session:
                    //                               session[_selectedSession],
                    //                           validity:
                    //                               validity[_selectedValidity],
                    //                         )));
                    //           },
                    //           child: Container(
                    //             padding: const EdgeInsets.all(5),
                    //             margin: const EdgeInsets.all(5),
                    //             decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(5),
                    //                 gradient: gridGradients[index]
                    //                 // color: colors[index],
                    //
                    //                 ),
                    //             child: Column(
                    //               children: [
                    //                 Text(
                    //                   session[index].toString(),
                    //                   style: const TextStyle(
                    //                       fontSize: 50,
                    //                       fontWeight: FontWeight.bold),
                    //                 ),
                    //                 const Text(
                    //                   'Sessions',
                    //                   style: TextStyle(
                    //                       fontSize: 16,
                    //                       fontWeight: FontWeight.bold),
                    //                 )
                    //               ],
                    //             ),
                    //           ),
                    //         );
                    //       })),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.all(10),
                    //   child: GridView.builder(
                    //       itemCount: session.length,
                    //       gridDelegate:
                    //           const SliverGridDelegateWithFixedCrossAxisCount(
                    //               mainAxisExtent: 120, crossAxisCount: 2),
                    //       itemBuilder: ((context, index) {
                    //         return InkWell(
                    //           onTap: () {
                    //             setState(() {
                    //               _selectedPerSession = index;
                    //               _selectedPrice = index;
                    //               _selectedSession = index;
                    //               _selectedValidity = index;
                    //             });
                    //             Navigator.push(
                    //                 context,
                    //                 MaterialPageRoute(
                    //                     builder: (context) => PackageDetail(
                    //                           gradient: gridGradients[index],
                    //                           perSession: perSession[
                    //                               _selectedPerSession],
                    //                           price: price[_selectedPrice],
                    //                           session:
                    //                               session[_selectedSession],
                    //                           validity:
                    //                               validity[_selectedValidity],
                    //                         )));
                    //           },
                    //           child: Container(
                    //             padding: const EdgeInsets.all(5),
                    //             margin: const EdgeInsets.all(5),
                    //             decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(5),
                    //                 gradient: gridGradients[index]),
                    //             child: Column(
                    //               children: [
                    //                 Text(
                    //                   session[index].toString(),
                    //                   style: const TextStyle(
                    //                       fontSize: 50,
                    //                       fontWeight: FontWeight.bold),
                    //                 ),
                    //                 const Text(
                    //                   'Sessions',
                    //                   style: TextStyle(
                    //                       fontSize: 20,
                    //                       fontWeight: FontWeight.bold),
                    //                 )
                    //               ],
                    //             ),
                    //           ),
                    //         );
                    //       })),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
