import 'package:flappy_bird/view/widgets/bird_widget.dart';
import 'package:flappy_bird/view/widgets/piller_part_widget.dart';
import 'package:flappy_bird/view/widgets/score_board_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      height: double.infinity,
      width: double.infinity,
      child: const Stack(
        children: [
          PillerPartWidget(),
          ScoreBoardWidget(),
          BirdWidget(),
        ],
      ),
    );
  }
}
