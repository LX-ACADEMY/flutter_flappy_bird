import 'package:flappy_bird/view/pages/starting_page.dart';
import 'package:flutter/material.dart';

void gameover(int highScore, int score, BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
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
                        fit: BoxFit.fitWidth)),
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
                  foregroundColor: WidgetStatePropertyAll(
                      Colors.red), // specify the text color here
                  backgroundColor: WidgetStatePropertyAll(
                      Colors.green), // specify the background color here
                ),
                child: const Text('RESTART'),
              ),
            ],
          ),
        );
      });
}
