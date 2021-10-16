import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:camera/camera.dart';
import 'package:yoga_posture_detection/screens/handle_camera.dart';

class ShowVideos extends StatefulWidget {
  final List<CameraDescription> cameras;
  const ShowVideos({required this.cameras});

  @override
  _ShowVideosState createState() => _ShowVideosState();
}

class _ShowVideosState extends State<ShowVideos> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  late CameraController controller;

  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.asset('videos/Bhumi_Trik.mp4');

    // Use the controller to loop the video.
    _controller.setLooping(true);

    _initializeVideoPlayerFuture = _controller.initialize();

    controller = CameraController(widget.cameras[1], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.black),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(5.0),
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                    child: Row(
                  children: [
                    Icon(
                      Icons.home,
                      color: Colors.white,
                      size: 32.0,
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(bottom: 5.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.white, width: 1.0))),
                        child: Text(
                          "Trikonasana - triangle pose",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ))),
            Expanded(
                flex: 7,
                child: Container(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Stack(
                    children: [
                      FutureBuilder(
                        future: _initializeVideoPlayerFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            // If the VideoPlayerController has finished initialization, use
                            // the data it provides to limit the aspect ratio of the video.
                            return AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              // Use the VideoPlayer widget to display the video.
                              child: VideoPlayer(_controller),
                            );
                          } else {
                            // If the VideoPlayerController is still initializing, show a
                            // loading spinner.
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            // Wrap the play or pause in a call to `setState`. This ensures the
                            // correct icon is shown.
                            setState(() {
                              // If the video is playing, pause it.
                              if (_controller.value.isPlaying) {
                                _controller.pause();
                              } else {
                                // If the video is paused, play it.
                                _controller.play();
                              }
                            });
                          },
                          // Display the correct icon depending on the state of the player.
                          child: Icon(
                            _controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Text(
                  //   "Instructor Tutorial",
                  //   style: TextStyle(color: Colors.white),
                  // ),
                )),
            Expanded(
                flex: 1,
                child: Container(
                  child: SizedBox(
                    height: 15.0,
                  ),
                )),
            Expanded(
                flex: 9,
                child: Container(
                  child: ShowCamera(controller),

                  // Text(
                  //   "User camera live video",
                  //   style: TextStyle(color: Colors.white),
                  // ),
                )),
          ],
        ),
      ),
    );
  }
}
