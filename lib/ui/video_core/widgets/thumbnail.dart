import 'package:flutter/material.dart';
import 'package:video_viewer/data/repositories/video.dart';
import 'package:video_viewer/ui/widgets/play_and_pause.dart';
import 'package:video_viewer/ui/widgets/transitions.dart';

class VideoCoreThumbnail extends StatefulWidget {
  const VideoCoreThumbnail({Key? key}) : super(key: key);

  @override
  _VideoCoreThumbnailState createState() => _VideoCoreThumbnailState();
}

class _VideoCoreThumbnailState extends State<VideoCoreThumbnail> {

  @override
  Widget build(BuildContext context) {
    final VideoQuery query = VideoQuery();
    final controller = query.video(context, listen: true);
    final style = query.videoStyle(context);

    final Widget? thumbnail = style.thumbnail;

    return CustomOpacityTransition(
      visible: controller.isShowingThumbnail,
      child: Stack(children: [
        if (thumbnail != null) Positioned.fill(child: thumbnail),
       if(controller.mounted)  Center(
            child: PlayAndPause(type: PlayAndPauseType.center,fromWhere: 3,)),
        if(controller.mounted)  Positioned.fill(
          child: GestureDetector(
            onTap: () async {
              await controller.play();
              controller.showAndHideOverlay();
            },
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
      ]),
    );
  }
}
