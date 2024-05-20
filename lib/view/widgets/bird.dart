import 'package:flutter/material.dart';

class Bird extends StatefulWidget {
  const Bird({super.key});

  @override
  State<Bird> createState() => _BirdState();
}

class _BirdState extends State<Bird> {
  var list = ["assets/birddf.png", "assets/birdmf.png", "assets/birduf.png"];
  late int i;

  @override
  void initState() {
    i = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    while (true) {
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
}
