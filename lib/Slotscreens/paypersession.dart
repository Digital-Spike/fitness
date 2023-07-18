import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fitness/constants/api_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
class PayPerSession extends StatefulWidget {
  const PayPerSession({super.key});

  
  @override
  State<PayPerSession> createState() => _PayPerSessionState();
}

class _PayPerSessionState extends State<PayPerSession> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Color(0xffE2EEFF),
      appBar: AppBar(
        backgroundColor: Color(0xffE2EEFF),
        title: Text('Pay Per Session',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black),),
leading: BackButton(color: Colors.black),
elevation: 0,
bottom: PreferredSize(child: Container(height: 1.0,color: Colors.black,), preferredSize: Size.fromHeight(1.0)),
      ),
      body: Column(
        children: [
          DropdownButton(items: const [], onChanged: (value){})
        ],
      ),
    );
  }
 
}