import 'dart:async';

import 'package:flutter/material.dart';

class Bird extends StatefulWidget {
  const Bird({super.key});

  @override
  State<Bird> createState() => _BirdState();
}

class _BirdState extends State<Bird> {
  var list = ["assets/birddf.png", "assets/birdmf.png", "assets/birduf.png"];
  int i = 0;

  @override
  void initState() {
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        i = timer.tick % list.length;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {});
      },
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(list[i]),
              fit: BoxFit.fill,
            )),
      ),
    );
  }
}
