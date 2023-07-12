import 'package:fitness/screens/homepage.dart';
import 'package:fitness/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Video extends StatefulWidget {
  const Video({super.key});

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();
    const url = "https://youtube.com/shorts/QxsWslmXgz4?feature=share";
    controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url)!,
        flags: const YoutubePlayerFlags(
            mute: false, loop: false, autoPlay: false,showLiveFullscreenButton: true));
  }

  @override
  void deactivate() {
    controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainScreen(
      mainAppBar: AppBar(
        backgroundColor: const Color(0xffE2EEFF),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Video',
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.black,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            height: 1.0,
            color: Colors.black,
          ),
        ),
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          },
        ),
      ),
      mainChild: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              YoutubePlayer(
                controller: controller,
                showVideoProgressIndicator: true,
                bottomActions: [
                  FullScreenButton(
                    controller: controller,
                  ),
                  CurrentPosition(),
                  ProgressBar(
                    isExpanded: true,
                    colors: const ProgressBarColors(
                      playedColor: Colors.deepOrange,
                      handleColor: Colors.orange,
                    ),
                  ),
                ],
              ),
              Text(controller.metadata.title)
            ],
          ),
        ),
      ),
    );
  }
}
