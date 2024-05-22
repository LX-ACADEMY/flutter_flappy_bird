import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScoreBoard extends StatelessWidget {
  final List<String> numbers = [
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
  final int score;

  ScoreBoard({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    List<String> scoreSplitted = score.toString().split('');
    final scoreImages =
        scoreSplitted.map((digit) => numbers[int.parse(digit)]).toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(15.0),
          child: SizedBox(
            height: 35,
            width: 35,
            child: Image(
              image: AssetImage('assets/pause.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height: 50,
          width: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: scoreImages.length,
            itemBuilder: (context, index) {
              return SizedBox(
                  height: 50,
                  width: 50,
                  child: Image(image: AssetImage(scoreImages[index])));
            },
          ),
        ),
      ],
    );
  }
}
