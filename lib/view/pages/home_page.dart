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
  late Timer _birdGravityTimer;
  late Timer _wordScrollTimer;

  /// Indicate if the game is already paused
  late bool isPaused;

  int score = 0;

  @override
  void initState() {
    worldScrollController = ScrollController();
    birdOffset = Offset.zero;
    birdKey = GlobalKey();
    isPaused = false;

    resumeGame(true);

    super.initState();
  }

  @override
  void dispose() {
    worldScrollController.dispose();
    _birdGravityTimer.cancel();
    _wordScrollTimer.cancel();

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
    setState(() {
      isPaused = true;
    });

    /// Stop the bird gravity
    _birdGravityTimer.cancel();

    /// Stop world scrolling
    _wordScrollTimer.cancel();
  }

  /// Start/Resume the game
  void resumeGame([bool isInitStateCall = false]) {
    if (!isInitStateCall) {
      setState(() {
        isPaused = false;
      });
    }

    /// Bird gravity movement start
    _birdGravityTimer = Timer.periodic(
      const Duration(milliseconds: 90),
      (timer) {
        setState(() {
          birdOffset = Offset(birdOffset.dx, birdOffset.dy + 10);
        });

        checkGroundCollision();
      },
    );

    /// Word scroll movement start
    Future.delayed(Duration.zero, () {
      return Timer.periodic(const Duration(milliseconds: 10), (timer) {
        worldScrollController.jumpTo(worldScrollController.offset + 1);
      });
    }).then((value) => _wordScrollTimer = value);
  }

  /// Update the score
  void updateScore(int newScore) {
    setState(() {
      score = newScore;
    });
  }

  /// Fly the bird upward
  void flyBird() {
    /// If the game is already paused, then do nothing
    if (isPaused) {
      return;
    }

    setState(() {
      birdOffset = Offset(birdOffset.dx, birdOffset.dy - 70);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: flyBird,
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/background.png'), fit: BoxFit.fill)),
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
            ScoreBoard(
              isPaused: isPaused,
              pauseGameCallback: pauseGame,
              resumeGameCallback: resumeGame,
              score: score,
            ),
            Positioned(
              top: MediaQuery.sizeOf(context).height * 0.5 - 25,
              left: MediaQuery.sizeOf(context).width * 0.5 - 105,
              child: Transform.translate(
                offset: birdOffset,
                child: Bird(
                  isPaused: isPaused,
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
