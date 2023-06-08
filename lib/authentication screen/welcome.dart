import 'package:fitness/authentication%20screen/splashSceen.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  // Initializing video player
  final VideoPlayerController videoPlayerController =
      VideoPlayerController.asset("assets/v2.mp4");

  ChewieController? chewieController;
  bool isPlaying = false;

  // Init state
  @override
  void initState() {
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 16 / 9, // Adjust this aspect ratio according to your video
      autoPlay: false, // Set autoPlay to false initially
      looping: true,
      autoInitialize: true,
      showControls: false,
    );
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController!.dispose();
    super.dispose();
  }

  void togglePlayPause() {
    if (isPlaying) {
      chewieController!.pause();
    } else {
      chewieController!.play();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned.fill(
            child: Chewie(
              controller: chewieController!,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.deepOrange,
                        ),
                        onPressed: togglePlayPause,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                      width: 150, // Set the desired width of the button
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepOrange,
                          padding: const EdgeInsets.symmetric(
                            vertical: 6.0,
                            horizontal: 10.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SplashScreen()));
                        },
                        child: const Text(
                          'Get Started',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                            letterSpacing: 0.5,
                          ),
                        ),
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
