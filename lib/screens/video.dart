import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'bottomnav.dart';

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
    const Url = "https://youtube.com/shorts/QxsWslmXgz4?feature=share";
    controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(Url)!,
        flags:
            const YoutubePlayerFlags(mute: false, loop: false, autoPlay: false));
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffF1F1F2),
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
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
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
        ));
  }
}
