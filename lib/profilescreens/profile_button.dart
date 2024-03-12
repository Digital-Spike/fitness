// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomButton extends StatelessWidget {
  final String title;

  final String svgPath;

  final VoidCallback onPressed;

  const CustomButton({
    required this.title,
    required this.svgPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5, top: 10),
      child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            minimumSize: Size(double.infinity, 56),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            side: BorderSide(color: Color(0xff142129), width: 1.5),
            padding: const EdgeInsets.all(15),
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontFamily: 'SpaceGrotesk'),
            ),
            SvgPicture.asset(
              'assets/svg/fjarrow.svg',
              color: Colors.white,
            ),
          ])),
    );
  }
}
