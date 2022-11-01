import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';

class CardVideoPlay extends StatefulWidget {
  final String? pathh;
  final bool view;
  const CardVideoPlay({Key? key, this.pathh, this.view = false})
      : super(key: key);

  @override
  State<CardVideoPlay> createState() => _CardVideoPlayState();
}

class _CardVideoPlayState extends State<CardVideoPlay> {
  ValueNotifier<VideoPlayerValue?> currentPosition = ValueNotifier(null);
  VideoPlayerController? _videoController;
  Future<void>? _initializeVideoPlayerFuture;
  bool isClicked = false; // boolean that states if the button is pressed or not

  initVideo() {
    _videoController = VideoPlayerController.network(widget.pathh!);

    _initializeVideoPlayerFuture = _videoController!.initialize();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    initVideo();
    _videoController!.addListener(() {
      if (_videoController!.value.isInitialized) {
        currentPosition.value = _videoController!.value;
      }
      if (_videoController!.value.position ==
          const Duration(seconds: 0, minutes: 0, hours: 0)) {
        debugPrint('video Started');
      }

      if (_videoController!.value.position ==
          _videoController!.value.duration) {
        debugPrint('video Ended');
        setState(() {
          isClicked = false;
        });
      }
      // if (_videoController!.value.isPlaying) {
      //   setState(() {
      //     isClicked = false;
      //   });
      // } else {
      //   setState(() {
      //     isClicked = true;
      //   });
      // }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _videoController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //debugPrint(widget.pathh);
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else {
          // If the VideoPlayerController has finished initialization, use
          // the data it provides to limit the aspect ratio of the video.
          return Stack(
            alignment: Alignment.center,
            children: [
              widget.view
                  ? AspectRatio(
                      aspectRatio: _videoController!.value.aspectRatio,
                      child: VideoPlayer(_videoController!),
                    )
                  : SizedBox(
                      width: double.infinity,
                      height: double.maxFinite,
                      child: VideoPlayer(_videoController!),
                    ),
              AnimatedOpacity(
                  opacity: isClicked ? 0.0 : 1.0,
                  duration: const Duration(
                      milliseconds:
                          100), // how much you want the animation to be long)
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        isClicked = !isClicked;
                        // If the video is playing, pause it.
                        if (_videoController!.value.isPlaying) {
                          _videoController!.pause();
                        } else {
                          // If the video is paused, play it.
                          _videoController!.play();
                        }
                      });
                    },
                    // icon: Icon(
                    //   _videoController!.value.isPlaying
                    //       ? Icons.pause
                    //       : Icons.play_circle_outlined,
                    //   size: 50,
                    //   color: Colors.white,
                    // ),
                    icon: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            shape: BoxShape.circle,
                            border: Border.all(width: 3, color: Colors.white)),
                        child: SvgPicture.asset(
                          "assets/icons/play-mini-fill-svgrepo-com.svg",
                          width: 60,
                          height: 60,
                          color: Colors.white,
                        )),
                    iconSize: 60,
                  )),
            ],
          );
        }
      },
    );
  }
}
