import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'addbooking.dart';

class Slot {
  final String time;
  final bool available;

  Slot({required this.time, required this.available});
}

class SlotAvailability extends StatefulWidget {
  @override
  _SlotAvailabilityState createState() => _SlotAvailabilityState();
}

class _SlotAvailabilityState extends State<SlotAvailability>
    with SingleTickerProviderStateMixin {
  bool _showCircle = false;

  late List<Slot> slots = [];
  late DateTime selectedDate;
  late TabController _tabController;

  Future<dynamic> loadData() async {
    setState(() {
      _showCircle = true;
    });

    String apiurl = "https://fitnessjourni.com/api/slotavailability.php";
    var response = await http.post(Uri.parse(apiurl),
        body: {"trainerId": "DIFC", "bookingDate": "2023/04/20"});

    var jsondata = json.decode(response.body);
    print(jsondata);

    List<Slot> updatedSlots = List.generate(13, (index) {
      bool isAvailable = jsondata[(index + 1).toString()] == "available";
      return Slot(
        time: getTime(index + 1),
        available: isAvailable,
      );
    });

    setState(() {
      slots = updatedSlots;
      _showCircle = false;
    });
  }

  String getTime(int slotId) {
    switch (slotId) {
      case 1:
        return "9:00 am - 9:45 am";
      case 2:
        return "9:45 am - 10:30 am";
      case 3:
        return "10:30 am - 11:15 am";
      case 4:
        return "11:15 am - 12:00 pm";
      case 5:
        return "12:00 pm - 12:45 pm";
      case 6:
        return "2:00 pm - 2:45 pm";
      case 7:
        return "2:45 pm - 3:30 pm";
      case 8:
        return "3:30 pm - 4:15 pm";
      case 9:
        return "4:15 pm - 5:00 pm";
      case 10:
        return "5:00 pm - 5:45 pm";
      case 11:
        return "5:45 pm - 6:30 pm";
      case 12:
        return "6:30 pm - 7:15 pm";
      case 13:
        return "7:15 pm - 8:00 pm";
      default:
        return "";
    }
  }

  Future<void> bookSlot(Slot slot) async {
    if (slot.available) {
      bool shouldBook = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: Text("Book Slot"),
            content: Text("Book your slot now?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true); // Book the slot
                },
                child: Text("OK"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // Cancel the booking
                },
                child: Text("Cancel"),
              ),
            ],
          );
        },
      );

      if (shouldBook) {
        // Perform the booking
        // ...
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: Text("Slot Unavailable"),
            content: Text("The selected slot is not available."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.index == _tabController.animation!.value) {
        if (_tabController.index == 0 && slots.isEmpty) {
          loadData();
        }
      }
    });
    loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Slot Availability"),
        backgroundColor: Colors.white, // Set the app bar color to white
        foregroundColor: Colors.black, // Set the app bar text color to black
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor:
                Colors.deepOrange, // Set the tab bar text color to deep orange
            tabs: [
              Tab(text: "Lists"), // Change tab 1 text to "Lists"
              Tab(text: "Weeks"), // Change tab 2 text to "Weeks"
              Tab(text: "Months"), // Change tab 3 text to "Months"
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildListsTab(slots), // Rename _buildTab to _buildListsTab
                _buildWeeksTab(
                    slots), // Create a new method _buildWeeksTab and pass slots
                _buildMonthsTab(
                    slots), // Create a new method _buildMonthsTab and pass slots
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///// lists section ////////////////////////
  Widget _buildListsTab(List<Slot> slots) {
    if (_showCircle) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.deepOrange),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Date: ${DateFormat('dd/MM/yyyy').format(selectedDate)}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Day: ${DateFormat('EEEE').format(selectedDate)}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: slots.length,
              itemBuilder: (context, index) {
                Slot slot = slots[index];
                bool isAvailable = slot.available;
                String buttonText = isAvailable ? 'Book' : 'Booked';
                Color buttonTextColor =
                    isAvailable ? Colors.black : Colors.white;
                Color buttonBorderColor =
                    isAvailable ? Colors.green : Colors.red;
                Color containerBorderColor = Colors.deepOrange;
                String slotTime = slot.time;

                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: containerBorderColor),
                  ),
                  child: ListTile(
                    title: Text(slotTime),
                    subtitle: Text(isAvailable ? "Available" : "Not Available"),
                    trailing: ElevatedButton(
                      onPressed: () {
                        if (isAvailable) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Alert'),
                                content: Text('Book your slot now'),
                                contentPadding: EdgeInsets.all(16.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                backgroundColor: Colors.white,
                                actions: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.orangeAccent,
                                          Colors.amber,
                                          Colors.orangeAccent,
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        stops: [0.2, 0.5, 0.8],
                                      ),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Addbooking()),
                                        );
                                      },
                                      child: Text('Book'),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.transparent,
                                        onPrimary: Colors.white,
                                        elevation: 0,
                                        textStyle: TextStyle(fontSize: 16.0),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Alert'),
                                content: Text(
                                    'This slot is already booked. Do you want to cancel the booking?'),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      // cancelBooking(slot);
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel Booking'),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red,
                                      onPrimary: Colors.white,
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: Text(
                        buttonText,
                        style: TextStyle(color: buttonTextColor),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: buttonTextColor,
                        side: BorderSide(color: buttonBorderColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    }
  }

  /////////////////////// weeks  ///////////////////////////
  Widget _buildWeeksTab(List<Slot> slots) {
    if (_showCircle) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 60.0, // Adjust the height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: slots.length,
                itemBuilder: (context, index) {
                  Slot slot = slots[index];
                  DateTime slotDateTime =
                      selectedDate.add(Duration(days: index));
                  String day = DateFormat('EEE').format(slotDateTime);
                  String date = DateFormat('dd').format(slotDateTime);

                  return Container(
                    width: 65.0,
                    height: 20.0, // Adjust the width as needed
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.deepOrange, Colors.white],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          day,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        Text(
                          date,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics:
                  NeverScrollableScrollPhysics(), // Disable scrolling for the inner ListView.builder
              itemCount: slots.length,
              itemBuilder: (context, index) {
                Slot slot = slots[index];
                if (slot.available) {
                  // Skip rendering the slot if it is available
                  return SizedBox.shrink();
                }

                bool isAvailable = slot.available;
                String buttonText = isAvailable ? 'Book' : 'Booked';
                Color buttonTextColor =
                    isAvailable ? Colors.black : Colors.white;
                Color buttonBorderColor =
                    isAvailable ? Colors.green : Colors.red;
                Color containerBorderColor = Colors.deepOrange;

                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: containerBorderColor),
                  ),
                  child: ListTile(
                    title: Text(slot.time),
                    subtitle: Text(isAvailable ? "Available" : "Not Available"),
                    trailing: ElevatedButton(
                      onPressed: isAvailable ? () => bookSlot(slot) : null,
                      child: Text(
                        buttonText,
                        style: TextStyle(color: buttonTextColor),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: buttonTextColor,
                        side: BorderSide(color: buttonBorderColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    }
  }

////////////////////////// months  //////////////////////////
  Widget _buildMonthsTab(List<Slot> slots) {
    return Column(
      children: [
        CalendarDatePicker(
          initialDate: selectedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime(2023, 12, 31),
          onDateChanged: (date) {
            setState(() {
              selectedDate = date;
            });
            loadData();
          },
        ),
        if (_showCircle)
          Center(
            child: CircularProgressIndicator(),
          )
        else
          Expanded(
            child: ListView.builder(
              itemCount: slots.length,
              itemBuilder: (context, index) {
                Slot slot = slots[index];
                String bookingStatus = slot.available ? "Book" : "Booked";
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(slot.time),
                    subtitle:
                        Text(slot.available ? "Available" : "Not Available"),
                    trailing: Text(bookingStatus),
                    onTap: () {
                      bookSlot(slot);
                    },
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  void main() {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SlotAvailability(),
    ));
  }
}
