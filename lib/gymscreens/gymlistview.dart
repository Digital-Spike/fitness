import 'package:flutter/material.dart';
class GymListView extends StatefulWidget {
  const GymListView({super.key});

  @override
  State<GymListView> createState() => _GymListViewState();
}

class _GymListViewState extends State<GymListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE2EEFF),
      appBar: AppBar(
        backgroundColor: Color(0xffE2EEFF),
        title: Text('Gym Branches',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black),),
        centerTitle: true,
        leading: BackButton(color: Colors.black,),
        elevation: 0,
        bottom: PreferredSize(child: Container(height: 1.0,color: Colors.black,), preferredSize: Size.fromHeight(1.0)),
      ),
      body: Column(
        children: [
          
        ],
      ),
    );
  }
}