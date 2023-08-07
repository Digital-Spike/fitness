import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final String svgPath;
  final IconData trailingIcon;
  final VoidCallback onPressed;

  CustomButton({
    required this.title,
    required this.subtitle,
    required this.svgPath,
    required this.trailingIcon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          primary: Colors.blueGrey[100], // Customize button color
          padding: EdgeInsets.all(5),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              svgPath,
              width: 30,
              height: 30,
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                ),
              ],
            ),
            Spacer(),
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
