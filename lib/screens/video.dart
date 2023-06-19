import 'package:fitness/screens/mainScreen.dart';
import 'package:flutter/material.dart';

class Video extends StatefulWidget {
  const Video({super.key});

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  @override
  Widget build(BuildContext context) {
    return MainScreen(
        mainAppBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text(
            'Video',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        mainChild: const Center(child: Text("Video section")));
  }
}
