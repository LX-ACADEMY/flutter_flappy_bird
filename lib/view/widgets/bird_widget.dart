import 'dart:async';

import 'package:flutter/material.dart';

class BirdWidget extends StatefulWidget {
  final bool isPaused;

  const BirdWidget({
    super.key,
    required this.isPaused,
  });

  @override
  State<BirdWidget> createState() => _BirdWidgetState();
}

class _BirdWidgetState extends State<BirdWidget> {
  //images for flapping the wing illusion creating
  var birdImages = [
    "assets/birddf.png",
    "assets/birdmf.png",
    "assets/birduf.png",
  ];

  int currentlyShownImage = 0;
  Timer? _birdWingsTimer;

  @override
  //this will start the animation
  void initState() {
    startBirdAnimation();

    super.initState();
  }

  @override
  //this is for using the functions in correct time stoping when outed or paused stop function will work,and start function will when resume.
  void didUpdateWidget(covariant BirdWidget oldWidget) {
    if (widget.isPaused) {
      stopBirdAnimation();
    } else if (_birdWingsTimer == null) {
      startBirdAnimation();
    }

    super.didUpdateWidget(oldWidget);
  }

  //for stoping animation
  void startBirdAnimation() {
    if (!widget.isPaused) {
      stopBirdAnimation();
    }

    _birdWingsTimer =
        Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        currentlyShownImage = timer.tick % birdImages.length;
      });
    });
  }

//for starting animation
  void stopBirdAnimation() {
    if (_birdWingsTimer != null) {
      _birdWingsTimer?.cancel();
      _birdWingsTimer = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    //bird design
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(birdImages[currentlyShownImage]),
            fit: BoxFit.fill,
          )),
    );
  }
}
