import 'package:flutter/material.dart';
import 'dart:ui';

class GlassBox1 extends StatelessWidget {
  final child;
  const GlassBox1({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 100,
        width: 320,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            alignment: Alignment.center,
            child: child,
          ),
        ),
      ),
    );
  }
}
