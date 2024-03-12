// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/Calender_package/datetimeline.dart';
import 'package:fitness/my_booking/slotBookingPage.dart';
import 'package:fitness/constants/api_list.dart';
import 'package:fitness/screens/notification.dart';
import 'package:fitness/screens/ourpackages.dart';

import 'package:fitness/trainerscreens/trainer_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import 'freetrialsession.dart';

const colorizeColors = [
  Colors.purple,
  Colors.blue,
];

const colorizeTextStyle = TextStyle(
    fontSize: 18.0, fontFamily: 'ITCAvant', fontWeight: FontWeight.w700);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTime _selectedDay = DateTime.now();
  final user = FirebaseAuth.instance.currentUser!;
  String? name;
  String imageUrl = "";
  static const url =
      'https://instagram.com/fitness_journey_uae?igshid=MzRlODBiNWFlZA==';
  final number = '+971588340905';
  launchWhatsApp() async {
    const link = WhatsAppUnilink(
      phoneNumber: '+971588340905',
      text: "Hi",
    );

    await launch('$link');
  }

  Future<void> contactDial(String number) async {
    await _launchCaller(number);
  }

  _launchCaller(String number) async {
    String url = Platform.isIOS ? 'tel://$number' : 'tel:$number';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  List trainersList = [];
  List branchList = [];
  Future<bool>? futureData;
  Future<bool>? futureData1;
  @override
  void initState() {
    getUser();
    getUser1();
    futureData = getBranchList();
    futureData1 = trainerList();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            toolbarHeight: 80,
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.circular(100),
                      color: Color(0xff142129)),
                  height: 60,
                  width: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: imageUrl,
                        errorWidget: (context, url, error) => Container(
                              padding: EdgeInsets.all(10),
                              child: SvgPicture.asset(
                                'assets/svg/fjuser.svg',
                                height: 10,
                                width: 10,
                              ),
                            )),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name != null ? '$name,' : '',
                      style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'SpaceGrotesk'),
                    ),
                    const Text(
                      'Welcome Back',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffFF6600),
                          fontFamily: 'SpaceGrotesk'),
                    )
                  ],
                ),
              ],
            ),
            centerTitle: false,
            automaticallyImplyLeading: false,
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Notifications()));
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: const Color(0xff142129),
                      borderRadius: BorderRadius.circular(15)),
                  child: SvgPicture.asset('assets/svg/bell.svg'),
                ),
              ),
              const SizedBox(
                width: 10,
              )
            ],
          ),
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: false,
                    expandedHeight: MediaQuery.of(context).size.height / 6,
                    flexibleSpace: FlexibleSpaceBar(
                      title: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const FreeTrialSession(
                                          isBranch: false,
                                          trainer: {},
                                        )));
                          },
                          child: Image.asset('assets/png/freetrial.png')),
                      titlePadding:
                          const EdgeInsets.only(right: 20, left: 20, top: 10),
                    ),
                    forceElevated: innerBoxIsScrolled,
                  ),
                ),
              ];
            },
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TabBar(
                      controller: _tabController,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.white,
                      indicatorPadding: EdgeInsets.zero,
                      indicator: const UnderlineTabIndicator(
                          borderSide:
                              BorderSide(width: 2, color: Colors.white)),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorWeight: 2,
                      tabs: [
                        Tab(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'EMS at Gym',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                fontFamily: 'SpaceGrotesk',
                                color: _tabController.index == 0
                                    ? Colors.white
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'EMS at Home',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                fontFamily: 'SpaceGrotesk',
                                color: _tabController.index == 1
                                    ? Colors.white
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(controller: _tabController, children: [
                        SafeArea(
                          top: false,
                          bottom: false,
                          child: Builder(
                            builder: (BuildContext context) {
                              return CustomScrollView(
                                slivers: <Widget>[
                                  SliverToBoxAdapter(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 15),
                                        const Text('Available Branches',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Work Sans')),
                                        FutureBuilder<bool>(
                                            future: futureData,
                                            builder: (BuildContext context,
                                                AsyncSnapshot<bool> snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.done) {
                                                return ListView.builder(
                                                    padding: EdgeInsets.zero,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    primary: false,
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        branchList.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          TrainerList(
                                                                            isBranchTrainers:
                                                                                true,
                                                                            branchId:
                                                                                branchList[index]['branchId'],
                                                                            branchName:
                                                                                branchList[index]['branch'],
                                                                            branchAddress:
                                                                                branchList[index]['address'],
                                                                          )));
                                                        },
                                                        child: Stack(
                                                          children: [
                                                            Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          5),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              decoration: BoxDecoration(
                                                                  color: const Color(
                                                                      0xff142129),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          120,
                                                                      width:
                                                                          100,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(10)),
                                                                      child:
                                                                          CachedNetworkImage(
                                                                        imageUrl:
                                                                            ApiList.imageUrl +
                                                                                (branchList[index]['image'] ?? ""),
                                                                        fit: BoxFit
                                                                            .fill,
                                                                        placeholder:
                                                                            (context, url) =>
                                                                                const Center(
                                                                          child:
                                                                              CircularProgressIndicator.adaptive(
                                                                            strokeAlign:
                                                                                1,
                                                                            backgroundColor:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                        errorWidget: (context,
                                                                                url,
                                                                                error) =>
                                                                            const Icon(Icons.error),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          10),
                                                                  Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      SizedBox(
                                                                        width: MediaQuery.of(context).size.width /
                                                                            1.9,
                                                                        child:
                                                                            Text(
                                                                          branchList[index]
                                                                              [
                                                                              'branch'],
                                                                          style: const TextStyle(
                                                                              fontSize: 17,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontFamily: 'SpaceGrotesk',
                                                                              color: Colors.white),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              5),
                                                                      Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          SvgPicture
                                                                              .asset(
                                                                            'assets/svg/marker.svg',
                                                                            height:
                                                                                13,
                                                                            width:
                                                                                8.3,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                MediaQuery.of(context).size.width / 2.3,
                                                                            child:
                                                                                Text(
                                                                              branchList[index]['address'].toString().replaceAll('\n', ''),
                                                                              style: const TextStyle(fontSize: 14, fontFamily: 'WorkSans'),
                                                                              softWrap: true,
                                                                              maxLines: 3,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Positioned(
                                                                bottom: 15,
                                                                right: 10,
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          7),
                                                                  width: 56,
                                                                  height: 32,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              16),
                                                                      border: Border.all(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Colors.white)),
                                                                  child: SvgPicture
                                                                      .asset(
                                                                          'assets/svg/fjarrow.svg'),
                                                                ))
                                                          ],
                                                        ),
                                                      );
                                                    });
                                              }
                                              if (snapshot.hasError) {
                                                const Text("Something wrong");
                                              }

                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator
                                                          .adaptive(
                                                backgroundColor: Colors.white,
                                              ));
                                            }),
                                        const SizedBox(height: 25),
                                        const Text(
                                          'Our Packages',
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontFamily: 'SpaceGrotesk'),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const OurPackages(
                                                                  initialtab: 0,
                                                                )));
                                                  },
                                                  child: Image.asset(
                                                    'assets/png/Single.png',
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const OurPackages(
                                                                  initialtab: 1,
                                                                )));
                                                  },
                                                  child: Image.asset(
                                                    'assets/png/Buddy.png',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 35),
                                        const Text(
                                          'Need assistance or have questions? Reach out to us for personalized support on your fitness journey!',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'SpaceGrotesk',
                                              fontSize: 17),
                                        ),
                                        const SizedBox(height: 15),
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    launch(
                                                        'tel://+971588340905');
                                                    launch('tel:+971588340905');
                                                    contactDial;
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            25),
                                                    height: 72,
                                                    width: 72,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        color: Colors.white),
                                                    child: SvgPicture.asset(
                                                      'assets/svg/call.svg',
                                                      height: 20,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 50),
                                                GestureDetector(
                                                  onTap: () async {
                                                    if (await canLaunch(url)) {
                                                      await launch(url);
                                                    } else {
                                                      throw 'Could not launch $url';
                                                    }
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            25),
                                                    height: 72,
                                                    width: 72,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        color: Colors.white),
                                                    child: SvgPicture.asset(
                                                      'assets/svg/instagram.svg',
                                                      height: 20,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Positioned(
                                                child: GestureDetector(
                                              onTap: () {
                                                launchWhatsApp();
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsets.all(25),
                                                height: 77,
                                                width: 77,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        width: 3,
                                                        color: Colors.black),
                                                    color: Colors.white),
                                                child: SvgPicture.asset(
                                                  'assets/svg/whatsapp.svg',
                                                  height: 20,
                                                ),
                                              ),
                                            ))
                                          ],
                                        ),
                                        const SizedBox(height: 50)
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        SafeArea(
                          top: false,
                          bottom: false,
                          child: Builder(
                            builder: (BuildContext context) {
                              return CustomScrollView(
                                slivers: <Widget>[
                                  SliverToBoxAdapter(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                formatDate(_selectedDay, [M])
                                                    .toUpperCase(),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'WorkSans'),
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                  formatDate(_selectedDay,
                                                      [yyyy]).toUpperCase(),
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'WorkSans')),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 100,
                                          width: double.infinity,
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
                                        const Text('Available Trainers',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Work Sans')),
                                        FutureBuilder<bool>(
                                            future: futureData,
                                            builder: (BuildContext context,
                                                AsyncSnapshot<bool> snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.done) {
                                                return ListView.builder(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    primary: false,
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        trainersList.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Stack(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          SlotBookingPage(
                                                                            isBranch:
                                                                                false,
                                                                            trainer:
                                                                                trainersList[index],
                                                                            trainerName:
                                                                                trainersList[index]['name'],
                                                                            branchAddress:
                                                                                '',
                                                                            trainerImage:
                                                                                trainersList[index]['image'],
                                                                            trainerRating:
                                                                                trainersList[index]['rating'],
                                                                            experience:
                                                                                trainersList[index]['description'],
                                                                            branchName:
                                                                                'Home',
                                                                          )));
                                                            },
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              margin:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          5),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  border: Border.all(
                                                                      width:
                                                                          1.5,
                                                                      color: const Color(
                                                                          0xff142129))),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Container(
                                                                        height:
                                                                            72,
                                                                        width:
                                                                            72,
                                                                        decoration:
                                                                            BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                                                        child:
                                                                            CachedNetworkImage(
                                                                          imageUrl:
                                                                              ApiList.imageUrl + (trainersList[index]['image'] ?? ""),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          placeholder: (context, url) =>
                                                                              const Center(
                                                                            child:
                                                                                CircularProgressIndicator.adaptive(
                                                                              backgroundColor: Colors.white,
                                                                            ),
                                                                          ),
                                                                          errorWidget: (context, url, error) =>
                                                                              const Icon(Icons.error),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                          width:
                                                                              10),
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
                                                                          const SizedBox(
                                                                              height: 5),
                                                                          Column(
                                                                            children: [
                                                                              if (trainersList[index]['rating'] == '1')
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
                                                                                    Text(trainersList[index]['rating'] + ' Rating', style: const TextStyle(fontSize: 14, fontFamily: 'WorkSans'))
                                                                                  ],
                                                                                ),
                                                                              if (trainersList[index]['rating'] == '2')
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
                                                                                    Text(trainersList[index]['rating'] + ' Rating', style: const TextStyle(fontSize: 14, fontFamily: 'WorkSans'))
                                                                                  ],
                                                                                ),
                                                                              if (trainersList[index]['rating'] == '3')
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
                                                                                    Text(trainersList[index]['rating'] + ' Rating', style: const TextStyle(fontSize: 14, fontFamily: 'WorkSans'))
                                                                                  ],
                                                                                ),
                                                                              if (trainersList[index]['rating'] == '4')
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
                                                                                    Text(trainersList[index]['rating'] + ' Rating', style: const TextStyle(fontSize: 14, fontFamily: 'WorkSans'))
                                                                                  ],
                                                                                ),
                                                                              if (trainersList[index]['rating'] == '5')
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
                                                                                      trainersList[index]['rating'] + ' Rating',
                                                                                      style: const TextStyle(fontSize: 14, fontFamily: 'WorkSans'),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                            ],
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 5),
                                                                          Container(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                                                                            decoration:
                                                                                BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white),
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                SvgPicture.asset('assets/svg/barbell.svg'),
                                                                                const SizedBox(width: 5),
                                                                                Text(
                                                                                  trainersList[index]['description'].toString().replaceAll('of experience', ''),
                                                                                  style: const TextStyle(fontSize: 14, color: Colors.black, fontFamily: 'WorkSans'),
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
                                                          ),
                                                          Positioned(
                                                              top: 15,
                                                              right: 10,
                                                              child: Row(
                                                                children: [
                                                                  Icon(
                                                                    CupertinoIcons
                                                                        .circle_fill,
                                                                    color: (trainersList[index]['status'] ==
                                                                            "ACTIVE")
                                                                        ? const Color(
                                                                            0xff74C76A)
                                                                        : const Color(
                                                                            0xffFD7278),
                                                                    size: 10,
                                                                  ),
                                                                  const SizedBox(
                                                                      width: 5),
                                                                  Text(
                                                                    (trainersList[index]['status'] ==
                                                                            "ACTIVE")
                                                                        ? 'Available'
                                                                        : 'Not Available',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize:
                                                                            12,
                                                                        fontFamily:
                                                                            'WorkSans',
                                                                        color: (trainersList[index]['status'] ==
                                                                                "ACTIVE")
                                                                            ? const Color(0xff74C76A)
                                                                            : const Color(0xffFD7278)),
                                                                  ),
                                                                ],
                                                              )),
                                                          Positioned(
                                                              bottom: 20,
                                                              right: 10,
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(7),
                                                                width: 56,
                                                                height: 32,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            16),
                                                                    border: Border.all(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .white)),
                                                                child: SvgPicture
                                                                    .asset(
                                                                        'assets/svg/fjarrow.svg'),
                                                              ))
                                                        ],
                                                      );
                                                    });
                                              }
                                              if (snapshot.hasError) {
                                                const Text("Something wrong");
                                              }

                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator
                                                          .adaptive(
                                                backgroundColor: Colors.white,
                                              ));
                                            }),
                                        const SizedBox(height: 25),
                                        const Text(
                                          'Our Packages',
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontFamily: 'SpaceGrotesk'),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const OurPackages(
                                                                  initialtab: 0,
                                                                )));
                                                  },
                                                  child: Image.asset(
                                                    'assets/png/Single.png',
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const OurPackages(
                                                                  initialtab: 1,
                                                                )));
                                                  },
                                                  child: Image.asset(
                                                    'assets/png/Buddy.png',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 35),
                                        const Text(
                                          'Need assistance or have questions? Reach out to us for personalized support on your fitness journey!',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'SpaceGrotesk',
                                              fontSize: 17),
                                        ),
                                        const SizedBox(height: 15),
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    launch(
                                                        'tel://+971588340905');
                                                    launch('tel:+971588340905');
                                                    contactDial;
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            25),
                                                    height: 72,
                                                    width: 72,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        color: Colors.white),
                                                    child: SvgPicture.asset(
                                                      'assets/svg/call.svg',
                                                      height: 20,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 50),
                                                GestureDetector(
                                                  onTap: () async {
                                                    if (await canLaunch(url)) {
                                                      await launch(url);
                                                    } else {
                                                      throw 'Could not launch $url';
                                                    }
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            25),
                                                    height: 72,
                                                    width: 72,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        color: Colors.white),
                                                    child: SvgPicture.asset(
                                                      'assets/svg/instagram.svg',
                                                      height: 20,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Positioned(
                                                child: GestureDetector(
                                              onTap: () {
                                                launchWhatsApp();
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsets.all(25),
                                                height: 77,
                                                width: 77,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        width: 3,
                                                        color: Colors.black),
                                                    color: Colors.white),
                                                child: SvgPicture.asset(
                                                  'assets/svg/whatsapp.svg',
                                                  height: 20,
                                                ),
                                              ),
                                            ))
                                          ],
                                        ),
                                        const SizedBox(height: 50)
                                      ],
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        )
                      ]),
                    ),
                  ]),
            ),
          )),
    );
  }

  void getUser() async {
    if (ApiList.user == null) {
      String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
      final response = await http.post(
        Uri.parse('https://fitnessjourni.com/api/getUser.php'),
        body: {
          'userId': userId,
        },
      );
      if (response.statusCode == 200) {
        ApiList.user = jsonDecode(response.body);
      }
    }
  }

  Future<String> getUser1() async {
    try {
      String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

      String url = 'https://fitnessjourni.com/api/getUser.php';

      var response = await http.post(Uri.parse(url), body: {'userId': userId});
      var jsondata = json.decode(response.body);

      setState(() {
        name = jsondata['name'];

        userId = jsondata['userId'];
        imageUrl = "https://fitnessjourni.com/api/uploads/$userId.png";
      });
      print(imageUrl);
    } on HandshakeException catch (_) {}
    return "success";
  }

  Future<bool> getBranchList() async {
    try {
      String trainerUrl = "${ApiList.apiUrl}getAllBranches.php";
      var response = await http.post(Uri.parse(trainerUrl), body: {});
      branchList = json.decode(response.body);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> trainerList() async {
    try {
      Response? response;
      {
        String trainerUrl = "${ApiList.apiUrl}getAllTrainers.php";
        response = await http.post(Uri.parse(trainerUrl), body: {});
      }

      trainersList = json.decode(response.body);
      return true;
    } catch (e) {
      return false;
    }
  }
}
