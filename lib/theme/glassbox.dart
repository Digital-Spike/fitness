import 'package:flutter/material.dart';
import 'dart:ui';

class Glassbox extends StatelessWidget {
  final child;
  const Glassbox({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(0),
      child: Container(
        height: 60,
        width: double.infinity,
        padding: EdgeInsets.all(2),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            alignment: Alignment.bottomCenter,
            child: child,
          ),
        ),
      ),
    );
  }
}
