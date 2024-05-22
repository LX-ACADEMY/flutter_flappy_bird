import 'package:flappy_bird/view/widgets/game_over_widget.dart';
import 'package:flutter/material.dart';

class PillerWidget extends StatefulWidget {
  final double pillerHeight;
  final bool isTopPiller;
  final ScrollController worldScrollController;
  final GlobalKey birdKey;
  late int pillerIndex;

  PillerWidget(
      {super.key,
      required this.birdKey,
      required this.worldScrollController,
      required this.isTopPiller,
      required this.pillerHeight,
      required this.pillerIndex});

  @override
  State<PillerWidget> createState() => _PillerWidgetState();
}

class _PillerWidgetState extends State<PillerWidget> {
  @override
  void initState() {
    widget.worldScrollController.addListener(checkPillerCollision);
    widget.worldScrollController.addListener(checkGroundCollision);

    super.initState();
  }

  @override
  void dispose() {
    widget.worldScrollController.removeListener(checkPillerCollision);
    widget.worldScrollController.removeListener(checkGroundCollision);

    super.dispose();
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
    final pillertopright = pillerBox.localToGlobal(Offset(pillerWidth, 0));
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
        // (birdbottomleft.dx >= pillertopleft.dx &&
        //     birdbottomleft.dx <= pillertopright.dx) ||
        // (birdbottomright.dx >= pillertopleft.dx &&
        //     birdbottomright.dx <= pillertopright.dx) ||
        ((birdtopright.dy >= pillertopleft.dy &&
                birdtopright.dy <= pillerbottomright.dy) ||
            (birdbottomright.dy >= pillertopleft.dy &&
                birdbottomright.dy <= pillerbottomright.dy))) {
      gameover(20, 5, context);
    }

    if ((birdtopleft.dy <= 0) && (widget.pillerIndex % 2 == 1)) {
      gameover(20, 5, context);
    }
  }

  void checkGroundCollision() {
    final birdBox =
        widget.birdKey.currentContext!.findRenderObject() as RenderBox;

    final birdHeight = birdBox.size.height;

    final Offset screensize =
        Offset(0, MediaQuery.of(context).size.height - 100);
    final birdbottomleft = birdBox.localToGlobal(Offset(0, birdHeight));

    if ((birdbottomleft.dy >= (screensize).dy)) {
      gameover(30, 8, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: widget.pillerHeight,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(widget.isTopPiller
              ? "assets/Pasted image (2).png"
              : "assets/Pasted image (3).png"),
          fit: BoxFit.fitWidth,
          alignment: widget.isTopPiller
              ? FractionalOffset.bottomCenter
              : FractionalOffset.topCenter,
        ),
      ),
    );
  }
}
