import 'dart:async';
import 'dart:math';

import 'package:flappy_bird/view/widgets/piller_top_widget.dart';
import 'package:flutter/material.dart';

class PillerPart extends StatefulWidget {
  final GlobalKey birdKey;
  final ScrollController worldScrollController;
  final void Function(int index) updateScore;

  const PillerPart({
    super.key,
    required this.birdKey,
    required this.worldScrollController,
    required this.updateScore,
  });

  @override
  State<PillerPart> createState() => _PillerPartState();
}

class _PillerPartState extends State<PillerPart> {
  final heightCache = List<double?>.generate(100, (index) => null);
  late int customIndex;

  Timer? timer;

  // @override
  // void initState() {
  //   final worldScrollController = ScrollController();

  //   super.initState();
  // }

  @override
  void didUpdateWidget(covariant PillerPart oldWidget) {
    timer?.cancel();
    timer = null;

    timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      widget.worldScrollController
          .jumpTo(widget.worldScrollController.offset + 1);
    });

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    late double pillerFullWidth = MediaQuery.of(context).size.height - 300;
    return ListView.builder(
      controller: widget.worldScrollController,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        double topPillerHeight;
        customIndex = index;
        Future.delayed(
            Duration.zero, () => widget.updateScore((index / 2).ceil() - 3));
        if (heightCache[index % 100] == null) {
          topPillerHeight =
              Random().nextInt(pillerFullWidth.toInt()).toDouble();
          heightCache[index % 100] = topPillerHeight;
        } else {
          topPillerHeight = heightCache[index % 100]!;
        }
        if (index < 3) {
          return SizedBox(
            height: double.infinity,
            width: 200,
            child: Column(
              children: [
                const Spacer(),
                Container(
                    width: double.infinity,
                    height: 100,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/Pasted image.png"),
                            fit: BoxFit.fill))),
              ],
            ),
          );
        } else if (index % 2 == 1) {
          return Container(
            height: double.infinity,
            color: Colors.transparent,
            width: 100,
            child: Column(
              children: [
                PillerWidget(
                  birdKey: widget.birdKey,
                  worldScrollController: widget.worldScrollController,
                  isTopPiller: true,
                  pillerHeight: topPillerHeight,
                  pillerIndex: customIndex,
                ),
                const Spacer(),
                PillerWidget(
                    pillerIndex: customIndex,
                    birdKey: widget.birdKey,
                    worldScrollController: widget.worldScrollController,
                    isTopPiller: false,
                    pillerHeight: pillerFullWidth - topPillerHeight),
                Container(
                    width: double.infinity,
                    height: 100,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/Pasted image.png"),
                            fit: BoxFit.fill))),
              ],
            ),
          );
        } else {
          return SizedBox(
            height: double.infinity,
            width: 200,
            child: Column(
              children: [
                const Spacer(),
                Container(
                    width: double.infinity,
                    height: 100,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/Pasted image.png"),
                            fit: BoxFit.fill))),
              ],
            ),
          );
        }
      },
    );
  }
}
