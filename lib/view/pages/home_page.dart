import 'dart:async';

import 'package:flappy_bird/view/widgets/bird.dart';
import 'package:flappy_bird/view/widgets/piller_part.dart';
import 'package:flappy_bird/view/widgets/score_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Offset birdOffset = Offset.zero;
  late GlobalKey birdkey;
  late ScrollController worldScrollController;

  @override
  void initState() {
    worldScrollController = ScrollController();
    birdkey = GlobalKey();
    Timer.periodic(
      const Duration(milliseconds: 90),
      (timer) {
        setState(() {
          birdOffset = Offset(birdOffset.dx, birdOffset.dy + 12);
        });
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          birdOffset = Offset(birdOffset.dx, birdOffset.dy - 70);
        });
      },
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bj.png'), fit: BoxFit.fill)),
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            PillerPart(
              worldScrollController: worldScrollController,
              birdKey: birdkey,
            ),
            ScoreBoard(),
            Positioned(
              top: MediaQuery.sizeOf(context).height * 0.5 - 25,
              left: MediaQuery.sizeOf(context).width * 0.5 - 105,
              child: Transform.translate(
                offset: birdOffset,
                child: Bird(
                  key: birdkey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
