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
  var birdImages = [
    "assets/birddf.png",
    "assets/birdmf.png",
    "assets/birduf.png",
  ];

  int currentlyShownImage = 0;
  Timer? _birdWingsTimer;

  @override
  void initState() {
    startBirdAnimation();

    super.initState();
  }

  @override
  void didUpdateWidget(covariant BirdWidget oldWidget) {
    if (widget.isPaused) {
      stopBirdAnimation();
    } else if (_birdWingsTimer == null) {
      startBirdAnimation();
    }

    super.didUpdateWidget(oldWidget);
  }

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

  void stopBirdAnimation() {
    if (_birdWingsTimer != null) {
      _birdWingsTimer?.cancel();
      _birdWingsTimer = null;
    }
  }

  @override
  Widget build(BuildContext context) {
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
