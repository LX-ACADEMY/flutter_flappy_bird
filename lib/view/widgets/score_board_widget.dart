import 'package:flappy_bird/view/widgets/score_number_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScoreBoardWidget extends StatelessWidget {
  final VoidCallback resumeGameCallback;
  final VoidCallback pauseGameCallback;
  final bool isPaused;
  final int score;
  final int highScore;

  const ScoreBoardWidget({
    super.key,
    required this.isPaused,
    required this.score,
    required this.highScore,
    required this.resumeGameCallback,
    required this.pauseGameCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      height: 100,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (isPaused) {
                resumeGameCallback();
              } else {
                pauseGameCallback();
              }
            },
            child: SizedBox(
              height: 35,
              width: 35,
              child: Image(
                image: AssetImage(isPaused
                    ? 'assets/img_resume_btn.png'
                    : 'assets/img_pause_btn.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Spacer(),
          ScoreNumberWidget(score: score),
        ],
      ),
    );
  }
}
