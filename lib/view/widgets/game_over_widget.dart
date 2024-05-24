import 'package:flappy_bird/view/pages/starting_page.dart';
import 'package:flappy_bird/view/widgets/score_number_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameOverWidget extends StatelessWidget {
  final int highScore;
  final int score;

  const GameOverWidget({
    super.key,
    required this.highScore,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(image: AssetImage('assets/gameover.png')),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 200,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: AssetImage('assets/gameoverscorescreen.png'),
                fit: BoxFit.fitWidth,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: 30,
                  top: 70,
                  child: SizedBox(
                    height: 20,
                    child: ScoreNumberWidget(score: score),
                  ),
                ),
                Positioned(
                  right: 30,
                  top: 125,
                  child: SizedBox(
                    height: 20,
                    child: ScoreNumberWidget(score: highScore),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const StartingPage()));
            },
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                Colors.white,
              ), // specify the background color here
            ),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Text('RESTART',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                    fontWeight: FontWeight.w800,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
