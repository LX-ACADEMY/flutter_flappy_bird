import 'package:flappy_bird/view/widgets/bird.dart';
import 'package:flappy_bird/view/widgets/piller_part.dart';
import 'package:flappy_bird/view/widgets/score_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bj.png'), fit: BoxFit.fill)),
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: [
          const PillerPart(),
          const ScoreBoard(),
          Positioned(
            top: MediaQuery.sizeOf(context).height * 0.5 - 40,
            left: MediaQuery.sizeOf(context).width * 0.5 - 40,
            child: const Bird(),
          ),
        ],
      ),
    );
  }
}
