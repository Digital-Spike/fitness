import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
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

class SlotBooking extends StatefulWidget {
  const SlotBooking({super.key});

  @override
  State<SlotBooking> createState() => _SlotBookingState();
}

class _SlotBookingState extends State<SlotBooking>
    with SingleTickerProviderStateMixin {
  late List<Slot> slots = [];
  CalendarFormat _calenderFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
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
        title: const Text('Slot Booking',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TableCalendar(
            rowHeight: 50,
            focusedDay: _focusedDay,
            firstDay: DateTime(2010),
            lastDay: DateTime(2030),
            calendarFormat: _calenderFormat,
            startingDayOfWeek: StartingDayOfWeek.monday,
            headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                leftChevronIcon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                rightChevronIcon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                )),
            daysOfWeekStyle: const DaysOfWeekStyle(
                weekendStyle: TextStyle(color: Colors.red)),
            calendarStyle: const CalendarStyle(
                weekendTextStyle: TextStyle(color: Colors.red),
                todayDecoration:
                    BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                defaultTextStyle: TextStyle(color: Colors.white),
                selectedDecoration: BoxDecoration(
                    color: Colors.orange, shape: BoxShape.circle)),
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onFormatChanged: (format) {
              if (_calenderFormat != format) {
                setState(() {
                  _calenderFormat = format;
                });
              }
            },
          ),
          const Divider(
            color: Colors.white,
            height: 1.0,
            thickness: 1.0,
          ),
          SizedBox(height: 15),
          Text('Available Slots',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          SizedBox(height: 10),
          Expanded(
              child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: EdgeInsets.all(16),
                height: 100,
                width: 350,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  title: Text('9:00 am - 9:45 am',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  subtitle: Text(
                    'Available',
                    style: TextStyle(color: Colors.green),
                  ),
                  trailing: Text('Book Now'),
                  onTap: () {},
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}
