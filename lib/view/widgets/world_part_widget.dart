import 'dart:async';
import 'dart:math';

import 'package:flappy_bird/view/widgets/floor_widget.dart';
import 'package:flappy_bird/view/widgets/piller_widget.dart';
import 'package:flutter/material.dart';

class WorldPartWidget extends StatefulWidget {
  final GlobalKey birdKey;
  final ScrollController worldScrollController;
  final VoidCallback updateScore;
  final VoidCallback pauseGameCallback;
  final int score;
  final int highScore;

  const WorldPartWidget({
    super.key,
    required this.birdKey,
    required this.pauseGameCallback,
    required this.worldScrollController,
    required this.updateScore,
    required this.score,
    required this.highScore,
  });

  @override
  State<WorldPartWidget> createState() => _WorldPartWidgetState();
}

class _WorldPartWidgetState extends State<WorldPartWidget> {
  final heightCache = List<double?>.generate(100, (index) => null);

  Timer? timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    //for getting full size of the top and bottom pillers
    late double pillerFullWidth = MediaQuery.of(context).size.height - 300;

    //for scrolling the screen of pillers
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      controller: widget.worldScrollController,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {

        /// Fetch the top piller height from cache if it exists
        double topPillerHeight;
        if (heightCache[index % 100] == null) {
          topPillerHeight =
              Random().nextInt(pillerFullWidth.toInt()).toDouble();
          heightCache[index % 100] = topPillerHeight;
        } else {
          topPillerHeight = heightCache[index % 100]!;
        }

        /// For the first 3 pillers and even pillers,  we will only show the floor 
        if (index < 3 || index % 2 == 0) {
          return const SizedBox(
            height: double.infinity,
            width: 200,
            child: Column(
              children: [
                Spacer(),
                FloorWidget(),
              ],
            ),
          );
        } else {
          /// Show the up and down pillers

          return SizedBox(
            height: double.infinity,
            width: 100,
            child: Column(
              children: [
                PillerWidget(
                  score: widget.score,
                  highScore: widget.highScore,
                  birdKey: widget.birdKey,
                  pasueGameCallback: widget.pauseGameCallback,
                  worldScrollController: widget.worldScrollController,
                  isTopPiller: true,
                  pillerHeight: topPillerHeight,
                  pillerIndex: index,
                  updateScoreCallback: widget.updateScore,
                ),
                const Spacer(),
                PillerWidget(
                    score: widget.score,
                    highScore: widget.highScore,
                    updateScoreCallback: widget.updateScore,
                    pillerIndex: index,
                    pasueGameCallback: widget.pauseGameCallback,
                    birdKey: widget.birdKey,
                    worldScrollController: widget.worldScrollController,
                    isTopPiller: false,
                    pillerHeight: pillerFullWidth - topPillerHeight),
                const FloorWidget(),
              ],
            ),
          );
        }
      },
    );
  }
}
