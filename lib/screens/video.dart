import 'package:fitness/screens/mainScreen.dart';
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
    const Url = "https://youtube.com/shorts/QxsWslmXgz4?feature=share";
    controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(Url)!,
        flags:
            const YoutubePlayerFlags(mute: false, loop: false, autoPlay: true));
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
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text(
            'Video',
            style: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.white,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              height: 1.0,
              color: Colors.white,
            ),
          ),
        ),
        mainChild: Column(
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
        ));
  }
}
