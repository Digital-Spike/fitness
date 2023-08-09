import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/constants/api_list.dart';
import 'package:fitness/constants/trainer_api.dart';
import 'package:fitness/theme/trainer_button.dart';
import 'package:fitness/traineraccount/completedsession.dart';
import 'package:fitness/traineraccount/upcomingsession.dart';
import 'package:fitness/traineraccount/updatedsession.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class TrainerHome extends StatefulWidget {
  const TrainerHome({super.key});

  @override
  State<TrainerHome> createState() => _TrainerHomeState();
}

class _TrainerHomeState extends State<TrainerHome> {
   final trainer = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: const CircleAvatar(
          minRadius: 30,
        ),
        toolbarHeight: 65,
        title: const Text('Trainer name'),
       
        automaticallyImplyLeading: false,
      ), body: SafeArea(
        child: Column(
          children: [   
            const SizedBox(height: 40),    
             TrainerButton(title: 'Upcoming Sessions', leadingColor: Colors.deepOrange, trailingIcon: Icons.arrow_forward_ios, onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context)=>const UpcomingSession()));}),
            TrainerButton(title: 'Completed Sessions', leadingColor: Colors.indigoAccent, trailingIcon: Icons.arrow_forward_ios, onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>const CompletedSession()));}),
            TrainerButton(title: 'Updated Sessions', leadingColor: Colors.amberAccent, trailingIcon: Icons.arrow_forward_ios, onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context)=>const UpdatedSession()));}),
            TrainerButton(title: 'EMS at Home/ Personal Trainer',  trailingIcon: Icons.arrow_forward_ios, onPressed: (){}, leadingColor: Colors.greenAccent,),
            Spacer(),
            Icon(Icons.home_filled,color: Color(0xff9EEB47),size: 35,),
            Text('Home',style: TextStyle(fontSize: 16,color: Color(0xff9EEB47)),)

          ],
        ),
      )  
    );
  }
   void getTrainer() async {
    if (TrainerApiList.trainer == null) {
      String trainerId = FirebaseAuth.instance.currentUser?.uid ?? '';
      final response = await http.post(
        Uri.parse('https://fitnessjourni.com/trainers/trainerLogin.php'),
        body: {'trainerId': trainerId},
      );
      if (response.statusCode == 200) {
        TrainerApiList.trainer = jsonDecode(response.body);
      }
    }
  }
}