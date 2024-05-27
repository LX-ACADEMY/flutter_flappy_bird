import 'dart:async';

import 'package:flappy_bird/view/widgets/bird_widget.dart';
import 'package:flappy_bird/view/widgets/game_over_widget.dart';
import 'package:flappy_bird/view/widgets/world_part_widget.dart';
import 'package:flappy_bird/view/widgets/score_board_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Offset birdOffset;
  late GlobalKey birdKey;
  late Timer _birdGravityTimer;
  late Timer _wordScrollTimer;
  late final ScrollController worldScrollController;

  /// Indicate if the game is already paused
  late bool isPaused;

  /// State to store the score of the game
  /// Default value is 0
  late int score;

  /// High score of the game
  late int highScore;

  @override
  void initState() {
    worldScrollController = ScrollController();
    birdOffset = Offset.zero;
    birdKey = GlobalKey();
    isPaused = false;

    score = 0;
    highScore = 0;

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

  //checking ground collision
  void checkGroundCollision() {
    final birdBox = birdKey.currentContext!.findRenderObject() as RenderBox;
    final birdHeight = birdBox.size.height;

    final Offset screensize =
        Offset(0, MediaQuery.of(context).size.height - 100);
    final birdbottomleft = birdBox.localToGlobal(Offset(0, birdHeight));

    if ((birdbottomleft.dy >= screensize.dy)) {
      pauseGame();
      showDialog(
        context: context,
        builder: (context) =>
            GameOverWidget(highScore: highScore, score: score),
      );
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
      const Duration(milliseconds: 10),
      (timer) {
        setState(() {
          birdOffset = Offset(birdOffset.dx, birdOffset.dy + 2.5);
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

  /// Increment the score
  void updateScore() {
    setState(() {
      score++;

      if (score > highScore) {
        highScore = score;
      }
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
            WorldPartWidget(
              score: score,
              highScore: highScore,
              pauseGameCallback: pauseGame,
              worldScrollController: worldScrollController,
              birdKey: birdKey,
              updateScore: updateScore,
            ),
            ScoreBoardWidget(
              isPaused: isPaused,
              pauseGameCallback: pauseGame,
              resumeGameCallback: resumeGame,
              score: score,
              highScore: highScore,
            ),
            Positioned(
              top: MediaQuery.sizeOf(context).height * 0.5 - 25,
              left: MediaQuery.sizeOf(context).width * 0.5 - 105,
              child: Transform.translate(
                offset: birdOffset,
                child: BirdWidget(
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
