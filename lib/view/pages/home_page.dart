import 'package:flappy_bird/view/pages/bird.dart';
import 'package:flappy_bird/view/pages/piller_part.dart';
import 'package:flappy_bird/view/pages/score_board.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bj.png'), fit: BoxFit.cover)),
      height: double.infinity,
      width: double.infinity,
      child: const Stack(
        children: [
          PillerPart(),
          ScoreBoard(),
          Bird(),
        ],
      ),
    );
  }
}
