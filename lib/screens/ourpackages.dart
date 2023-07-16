import 'package:flutter/material.dart';
class OurPackages extends StatefulWidget {
  const OurPackages({super.key});

  @override
  State<OurPackages> createState() => _OurPackagesState();
}

class _OurPackagesState extends State<OurPackages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE2EEFF),
      appBar: AppBar(
        backgroundColor:  Color(0xffE2EEFF),
        title: Text('Our Packages',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black),),
        leading: BackButton(color: Colors.black),
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(child: Container(height: 1.0,color: Colors.black,), preferredSize: Size.fromHeight(1.0)),
      ),
    );
  }
}