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

  const PillerWidget({
    super.key,
    required this.birdKey,
    required this.worldScrollController,
    required this.isTopPiller,
    required this.pillerHeight,
    required this.pillerIndex,
    required this.pasueGameCallback,
  });

  @override
  State<PillerWidget> createState() => _PillerWidgetState();
}

class _PillerWidgetState extends State<PillerWidget> {
  late bool isGamePaused;

  @override
  void initState() {
    // widget.worldScrollController.addListener(checkPillerCollision);
    isGamePaused = false;

    super.initState();
  }

  @override
  void dispose() {
    widget.worldScrollController.removeListener(checkPillerCollision);

    super.dispose();
  }

  /// Remove all collision listeners
  void removeListeners() {
    widget.worldScrollController.removeListener(checkPillerCollision);

    widget.pasueGameCallback();
  }

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

    if ((birdtopleft.dy <= 0) && (widget.pillerIndex % 2 == 1)) {
      showGameOverScreen();
    }
  }

  /// Show game over screen
  void showGameOverScreen() {
    removeListeners();

    if (!isGamePaused) {
      gameover(20, 5, context);
    }

    isGamePaused = true;
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   width: 100,
    //   height: widget.pillerHeight,
    //   decoration: BoxDecoration(
    //     image: DecorationImage(
    //       image: AssetImage(widget.isTopPiller
    //           ? "assets/top_piller.png"
    //           : "assets/bottom_piller.png"),
    //       fit: BoxFit.fitWidth,
    //       alignment: widget.isTopPiller
    //           ? FractionalOffset.bottomCenter
    //           : FractionalOffset.topCenter,
    //     ),
    //   ),
    // );

    return SizedBox(
      width: 100,
      height: widget.pillerHeight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!widget.isTopPiller)
            SizedBox(
              width: 100,
              child: Image.asset(
                'assets/img_pipe_head.png',
                fit: BoxFit.fitWidth,
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
          if (widget.isTopPiller)
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(pi)..rotateZ(pi),
              child: SizedBox(
                width: 100,
                child: Image.asset(
                  'assets/img_pipe_head.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
