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
     // backgroundColor: Color(0xffFEF6E4),
      appBar: AppBar(
     //   backgroundColor:  Color(0xffF5E6C2),
        title: Text('Offers',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,),),
        leading: BackButton(),
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(child: Container(height: 1.0,color: Colors.black,), preferredSize: Size.fromHeight(1.0)),
      ),
     
    );
  }
}