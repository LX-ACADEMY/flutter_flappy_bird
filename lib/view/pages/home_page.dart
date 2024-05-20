import 'package:flappy_bird/view/widgets/bird.dart';
import 'package:flappy_bird/view/widgets/piller_part.dart';
import 'package:flappy_bird/view/widgets/score_board.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bj.png'), fit: BoxFit.fill)),
      height: double.infinity,
      width: double.infinity,
      child:  Stack(
        children: [
          PillerPart(),
          ScoreBoard(),
          Bird(),
        ],
      ),
    );
  }
}
