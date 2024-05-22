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
  final int score = 0123;
  ScoreBoard({super.key});

  @override
  Widget build(BuildContext context) {
    int scorelength = score.toString().length;
    List<String> switchcheckingscore = score.toString().split('');
    List<String> scorestorage = [];
    for (int i = 0; i < scorelength; i++) {
      switch (switchcheckingscore[i]) {
        case '0':
          scorestorage.add(numbers[0]);
          break;
        case '1':
          scorestorage.add(numbers[1]);
          break;

        case '2':
          scorestorage.add(numbers[2]);
          break;

        case '3':
          scorestorage.add(numbers[3]);
          break;

        case '4':
          scorestorage.add(numbers[4]);
          break;

        case '5':
          scorestorage.add(numbers[5]);
          break;

        case '6':
          scorestorage.add(numbers[6]);
          break;
        case '7':
          scorestorage.add(numbers[7]);
          break;
        case '8':
          scorestorage.add(numbers[8]);
          break;
        case '9':
          scorestorage.add(numbers[9]);
      }
    }

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
        // const Spacer(),
        SizedBox(
          height: 50,
          width: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: scorelength,
            itemBuilder: (context, index) {
              return SizedBox(
                  height: 50,
                  width: 50,
                  child: Image(image: AssetImage(scorestorage[index])));
            },
          ),
        ),
        // const Spacer()
      ],
    );
  }
}
