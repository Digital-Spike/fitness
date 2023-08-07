import 'package:fitness/theme/trainer_button.dart';
import 'package:fitness/traineraccount/bottomnav.dart';
import 'package:fitness/traineraccount/completedsession.dart';
import 'package:fitness/traineraccount/upcomingsession.dart';
import 'package:fitness/traineraccount/updatedsession.dart';
import 'package:flutter/material.dart';
class TrainerHome extends StatefulWidget {
  const TrainerHome({super.key});

  @override
  State<TrainerHome> createState() => _TrainerHomeState();
}

class _TrainerHomeState extends State<TrainerHome> {
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
        actions: [
          const Icon(Icons.home_outlined),SizedBox(width: 10)
        ],
       
        automaticallyImplyLeading: false,
      ), body: SafeArea(
        child: Column(
          children: [
            
            
             TrainerButton(title: 'Upcoming Sessions', leadingColor: Colors.deepOrange, trailingIcon: Icons.arrow_forward_ios, onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context)=>const UpcomingSession()));}),
            TrainerButton(title: 'Completed Sessions', leadingColor: Colors.indigoAccent, trailingIcon: Icons.arrow_forward_ios, onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>const CompletedSession()));}),
            TrainerButton(title: 'Updated Sessions', leadingColor: Colors.amberAccent, trailingIcon: Icons.arrow_forward_ios, onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context)=>const UpdatedSession()));}),
            TrainerButton(title: 'EMS at Home/ Personal Trainer',  trailingIcon: Icons.arrow_forward_ios, onPressed: (){}, leadingColor: Colors.greenAccent,)
          ],
        ),
      )
      
    );
  }
}