import 'package:flutter/material.dart';

class ScoreNumberWidget extends StatelessWidget {
  final int score;

  ScoreNumberWidget({
    super.key,
    required this.score,
  });

  final List<String> numbersImages = [
    'assets/numbers/0.png',
    'assets/numbers/1.png',
    'assets/numbers/2.png',
    'assets/numbers/3.png',
    'assets/numbers/4.png',
    'assets/numbers/5.png',
    'assets/numbers/6.png',
    'assets/numbers/7.png',
    'assets/numbers/8.png',
    'assets/numbers/9.png',
  ];

  @override
  Widget build(BuildContext context) {
    final scoreSplitted = score.toString().split('');
    final scoreImages =
        scoreSplitted.map((digit) => numbersImages[int.parse(digit)]).toList();

    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: scoreImages.length,
      itemBuilder: (context, index) {
        return SizedBox(
          child: Image(
            image: AssetImage(
              scoreImages[index],
            ),
          ),
        );
      },
    );
  }
}
