import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Slot {
  final String time;
  final bool available;
  final String bookingStatus;

  Slot(
      {required this.time,
      required this.available,
      required this.bookingStatus});
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
      String bookingStatus = isAvailable ? "Book" : "Booked";
      return Slot(
        time: getTime(index + 1),
        available: isAvailable,
        bookingStatus: bookingStatus,
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
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Create a new method _buildWeeksTab and pass slots
                _buildMonthsTab(
                    slots), // Create a new method _buildMonthsTab and pass slots
              ],
            ),
          ),
        ],
      ),
    );
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
                Color backgroundColor = Colors.white;
                Color textColor = Colors.black;
                Color borderColor = Colors.grey;
                String bookingStatus = slot.bookingStatus;

                if (slot.available) {
                  backgroundColor = Colors.black;
                  textColor = Colors.white;
                  borderColor = Colors.deepOrange;
                } else {
                  backgroundColor = Colors.red;
                  textColor = Colors.white;
                }

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    border: Border.all(color: borderColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(
                      slot.time,
                      style: TextStyle(color: textColor),
                    ),
                    subtitle: Text(
                      slot.available ? "Available" : "Not Available",
                      style: TextStyle(color: textColor),
                    ),
                    trailing: Text(
                      bookingStatus,
                      style: TextStyle(color: textColor),
                    ),
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
      home: Scaffold(
        body: SlotAvailability(),
      ),
    ));
  }
}
