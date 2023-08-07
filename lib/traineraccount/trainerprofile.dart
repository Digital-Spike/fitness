import 'package:fitness/traineraccount/bottomnav.dart';
import 'package:flutter/material.dart';
class TrainerAccount extends StatefulWidget {
  const TrainerAccount({super.key});

  @override
  State<TrainerAccount> createState() => _TrainerProfileState();
}

class _TrainerProfileState extends State<TrainerAccount> {
  @override
  Widget build(BuildContext context) {
    return Tscreen( 
      trainerAppbar: AppBar(
        automaticallyImplyLeading: false,
      ),
      trainerChild: Column());
  }
}