import 'package:fitness/screens/mainScreen.dart';
import 'package:flutter/material.dart';

class TrainerDetailPage extends StatefulWidget {
  final Map<String, dynamic> trainer;

  const TrainerDetailPage({Key? key, required this.trainer}) : super(key: key);

  @override
  State<TrainerDetailPage> createState() => _TrainerDetailPageState();
}

class _TrainerDetailPageState extends State<TrainerDetailPage> {
  Map<String, dynamic> trainer = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScreen(
      backgroundColor: Colors.black,
      mainAppBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Trainer",
          style: TextStyle(color: Colors.white),
        ),
      ),
      mainChild: Container(
        color: Colors.black,
        child: SingleChildScrollView(
          child: Column(
            children: const [SizedBox(height: 16), Text("data")],
          ),
        ),
      ),
    );
  }
}
