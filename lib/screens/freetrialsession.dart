import 'package:flutter/material.dart';
class FreeTrialSession extends StatefulWidget {
  const FreeTrialSession({super.key});

  @override
  State<FreeTrialSession> createState() => _FreeTrialSessionState();
}

class _FreeTrialSessionState extends State<FreeTrialSession> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F1F2),
      appBar: AppBar(
        backgroundColor: Color(0xffF1F1F2),
        title: Text('Free Trial Session',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),),
        leading: BackButton(color: Colors.black),
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