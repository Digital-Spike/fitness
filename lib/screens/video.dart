import 'package:flutter/material.dart';

class Video extends StatefulWidget {
  const Video({Key? key});

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Video',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
