import 'dart:async';

import 'package:flappy_bird/view/widgets/bird.dart';
import 'package:flappy_bird/view/widgets/game_over_widget.dart';
import 'package:flappy_bird/view/widgets/piller_part.dart';
import 'package:flappy_bird/view/widgets/score_board.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Offset birdOffset;
  late GlobalKey birdKey;
  late final ScrollController worldScrollController;
  late final Timer _birdGravityTimer;
  late final Timer _wordScrollTimer;

  int score = 0;

  @override
  void initState() {
    worldScrollController = ScrollController();
    birdOffset = Offset.zero;
    birdKey = GlobalKey();

    /// Bird gravity movement
    _birdGravityTimer = Timer.periodic(
      const Duration(milliseconds: 90),
      (timer) {
        setState(() {
          birdOffset = Offset(birdOffset.dx, birdOffset.dy + 10);
        });

        checkGroundCollision();
      },
    );

    Future.delayed(Duration.zero, () {
      return Timer.periodic(const Duration(milliseconds: 10), (timer) {
        worldScrollController.jumpTo(worldScrollController.offset + 1);
      });
    }).then((value) => _wordScrollTimer = value);

    super.initState();
  }

  @override
  void dispose() {
    worldScrollController.dispose();
    _birdGravityTimer.cancel();

    super.dispose();
  }

  void checkGroundCollision() {
    final birdBox = birdKey.currentContext!.findRenderObject() as RenderBox;
    final birdHeight = birdBox.size.height;

    final Offset screensize =
        Offset(0, MediaQuery.of(context).size.height - 100);
    final birdbottomleft = birdBox.localToGlobal(Offset(0, birdHeight));

    if ((birdbottomleft.dy >= screensize.dy)) {
      pauseGame();
      gameover(0, score, context);
    }
  }

  /// Pause the game
  void pauseGame() {
    /// Stop the bird gravity
    _birdGravityTimer.cancel();

    /// Stop world scrolling
    _wordScrollTimer.cancel();
  }

  /// Update the score
  void updateScore(int newScore) {
    setState(() {
      score = newScore;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /// Bird fly up
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
              pauseGameCallback: pauseGame,
              worldScrollController: worldScrollController,
              birdKey: birdKey,
              updateScore: updateScore,
            ),
            ScoreBoard(score: score),
            Positioned(
              top: MediaQuery.sizeOf(context).height * 0.5 - 25,
              left: MediaQuery.sizeOf(context).width * 0.5 - 105,
              child: Transform.translate(
                offset: birdOffset,
                child: Bird(
                  key: birdKey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
