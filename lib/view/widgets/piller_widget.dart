import 'dart:math';

import 'package:flappy_bird/view/widgets/game_over_widget.dart';
import 'package:flutter/material.dart';

class PillerWidget extends StatefulWidget {
  final double pillerHeight;
  final bool isTopPiller;
  final ScrollController worldScrollController;
  final GlobalKey birdKey;
  final int pillerIndex;
  final VoidCallback pasueGameCallback;
  final VoidCallback updateScoreCallback;
  final int score;
  final int highScore;

  const PillerWidget({
    super.key,
    required this.birdKey,
    required this.worldScrollController,
    required this.isTopPiller,
    required this.pillerHeight,
    required this.pillerIndex,
    required this.pasueGameCallback,
    required this.updateScoreCallback,
    required this.score,
    required this.highScore,
  });

  @override
  State<PillerWidget> createState() => _PillerWidgetState();
}

class _PillerWidgetState extends State<PillerWidget> {
  late bool isGamePaused;
  late bool isBirdPassedPiller;

  @override
  void initState() {
    widget.worldScrollController.addListener(checkPillerCollision);

    /// If the widget is top piller, we will check if the bird has passed the piller
    if (widget.isTopPiller) {
      widget.worldScrollController.addListener(checkBirdPassedPiller);
    }

    isGamePaused = false;
    isBirdPassedPiller = false;

    super.initState();
  }

  @override
  void dispose() {
    widget.worldScrollController.removeListener(checkPillerCollision);
    widget.worldScrollController.removeListener(checkBirdPassedPiller);

    super.dispose();
  }

  /// Remove all collision listeners
  void removeListeners() {
    widget.worldScrollController.removeListener(checkPillerCollision);

    widget.pasueGameCallback();
  }

  /// Check if the bird has passed the piller
  /// and update the score
  void checkBirdPassedPiller() {
    if (isBirdPassedPiller) {
      return;
    }

    final birdBox =
        widget.birdKey.currentContext!.findRenderObject() as RenderBox;
    final birdtopleft = birdBox.localToGlobal(Offset.zero);

    final pillerBox = context.findRenderObject() as RenderBox;
    final pillerWidth = pillerBox.size.width;
    final pillerTopRight = pillerBox.localToGlobal(Offset(pillerWidth, 0));

    if (birdtopleft.dx > pillerTopRight.dx) {
      isBirdPassedPiller = true;

      widget.updateScoreCallback();
      widget.worldScrollController.removeListener(checkBirdPassedPiller);
    }
  }

  //checking piller collision 
  void checkPillerCollision() {
    final pillerBox = context.findRenderObject() as RenderBox;
    final birdBox =
        widget.birdKey.currentContext!.findRenderObject() as RenderBox;

    final pillerHeight = pillerBox.size.height;
    final pillerWidth = pillerBox.size.width;
    final birdHeight = birdBox.size.height;
    final birdWidth = birdBox.size.width;

    final pillertopleft = pillerBox.localToGlobal(Offset.zero);
    final pillerbottomleft = pillerBox.localToGlobal(Offset(0, pillerHeight));
    final pillerbottomright =
        pillerBox.localToGlobal(Offset(pillerWidth, pillerHeight));

    final birdtopleft = birdBox.localToGlobal(Offset.zero);
    final birdtopright = birdBox.localToGlobal(Offset(birdWidth, 0));
    final birdbottomleft = birdBox.localToGlobal(Offset(0, birdHeight));
    final birdbottomright =
        birdBox.localToGlobal(Offset(birdWidth, birdHeight));

    if (((birdtopleft.dx >= pillerbottomleft.dx &&
                birdbottomleft.dx <= pillerbottomright.dx) ||
            (birdtopright.dx >= pillerbottomleft.dx &&
                birdtopright.dx <= pillerbottomright.dx)) &&
        ((birdtopright.dy >= pillertopleft.dy &&
                birdtopright.dy <= pillerbottomright.dy) ||
            (birdbottomright.dy >= pillertopleft.dy &&
                birdbottomright.dy <= pillerbottomright.dy))) {
      showGameOverScreen();
    }

    //collision checking upper the screen
    if ((birdtopleft.dy <= 0) && (widget.pillerIndex % 2 == 1)) {
      showGameOverScreen();
    }
  }

  /// Show game over screen
  void showGameOverScreen() {
    removeListeners();

    if (!isGamePaused) {
      showDialog(
        context: context,
        builder: (context) => GameOverWidget(
          highScore: widget.highScore,
          score: widget.score,
        ),
      );
    }

    isGamePaused = true;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: widget.pillerHeight,
      child: Column(
        
        children: [
          //adding head of the piller for bottom piller
          if (!widget.isTopPiller)
            Container(
              height: min(50, widget.pillerHeight),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img_pipe_head.png'),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
          Expanded(
            child: SizedBox(
              width: 100,
              child: Image.asset(
                'assets/img_pipe_body.png',
                fit: BoxFit.fill,
              ),
            ),
          ),

          //adding head of the piller for top piller
          if (widget.isTopPiller)
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(pi)..rotateZ(pi),
              child: Container(
                height: min(50, widget.pillerHeight),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/img_pipe_head.png'),
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
