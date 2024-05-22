import 'dart:async';

import 'package:flutter/material.dart';

class Bird extends StatefulWidget {
  final bool isPaused;

  const Bird({
    super.key,
    required this.isPaused,
  });

  @override
  State<Bird> createState() => _BirdState();
}

class _BirdState extends State<Bird> {
  var list = ["assets/birddf.png", "assets/birdmf.png", "assets/birduf.png"];
  int i = 0;
  Timer? _birdWingsTimer;

  @override
  void initState() {
    startBirdAnimation();

    super.initState();
  }

  @override
  void didUpdateWidget(covariant Bird oldWidget) {
    if (widget.isPaused) {
      stopBirdAnimation();
    } else {
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
        i = timer.tick % list.length;
      });
    });
  }

  void stopBirdAnimation() {
    _birdWingsTimer?.cancel();
    _birdWingsTimer = null;
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
            image: AssetImage(list[i]),
            fit: BoxFit.fill,
          )),
    );
  }
}
