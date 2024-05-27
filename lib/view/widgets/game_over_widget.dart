import 'package:flappy_bird/view/pages/starting_page.dart';
import 'package:flappy_bird/view/widgets/score_number_widget.dart';
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
    //show the game over alert when outed
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //game over logo
          const Image(image: AssetImage('assets/gameover.png')),
          //a gap
          const SizedBox(
            height: 20,
          ),
          //container for showing score and highscore
          Container(
            height: 200,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: AssetImage('assets/gameoverscorescreen.png'),
                fit: BoxFit.fitWidth,
              ),
            ), //score and highscore show
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
          //a gap
          const SizedBox(
            height: 20,
          ), //button for restart
          GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StartingPage(),
                  ), (route) {
                return false;
              });
            },
            //restart logo
            child: SizedBox(
              width: 140,
              child: Image.asset(
                'assets/img_btn_restart.png',
              ),
            ),
          )
        ],
      ),
    );
  }
}
