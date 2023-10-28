// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final String svgPath;

  final IconData trailingIcon;
  final VoidCallback onPressed;

  const CustomButton({
    required this.title,
    required this.subtitle,
    required this.svgPath,
    required this.trailingIcon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5, top: 10),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          primary: Colors.blueGrey[100], // Customize button color
          padding: const EdgeInsets.all(10),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              svgPath,
              height: 30,
              width: 30,
              color: Colors.black,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.grey[800]),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              trailingIcon,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
