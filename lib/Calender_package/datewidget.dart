import 'package:fitness/Calender_package/tap.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateWidget extends StatelessWidget {
  final double? width;
  final DateTime date;
  final TextStyle? dayTextStyle, dateTextStyle;
  final Color selectionColor;
  final Color selectionDateColor;
  final Color selectionContainerColor;
  final DateSelectionCallback? onDateSelected;
  final String? locale;

  DateWidget({
    required this.date,
    required this.dayTextStyle,
    required this.dateTextStyle,
    required this.selectionColor,
    required this.selectionDateColor,
    required this.selectionContainerColor,
    this.width,
    this.onDateSelected,
    this.locale,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(5),
        width: width,
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: selectionColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 40,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: selectionDateColor),
              child: Center(
                child: Text(date.day.toString(), // Date
                    style: dateTextStyle),
              ),
            ),
            Text(
                new DateFormat("E", locale)
                    .format(date)
                    .toUpperCase(), // WeekDay
                style: dayTextStyle),
            Container(
              width: 12,
              height: 2,
              color: selectionContainerColor,
            ),
            SizedBox(height: 1)
          ],
        ),
      ),
      borderRadius: BorderRadius.all(Radius.circular(30)),
      onTap: () {
        // Check if onDateSelected is not null
        if (onDateSelected != null) {
          // Call the onDateSelected Function
          onDateSelected!(this.date);
        }
      },
    );
  }
}
