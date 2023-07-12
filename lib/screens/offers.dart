import 'package:flutter/material.dart';
class Offers extends StatefulWidget {
  const Offers({super.key});

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE2EEFF),
      appBar: AppBar(
        backgroundColor:  Color(0xffE2EEFF),
        title: Text('Offers',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black),),
        leading: BackButton(color: Colors.black),
        elevation: 0,
        bottom: PreferredSize(child: Container(height: 1.0,color: Colors.black,), preferredSize: Size.fromHeight(1.0)),
      ),
    );
  }
}