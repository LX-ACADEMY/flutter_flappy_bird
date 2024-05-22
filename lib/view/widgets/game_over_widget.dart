import 'package:flappy_bird/view/pages/home_page.dart';
import 'package:flutter/material.dart';

void gameover(int hs, s, context) {
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
                height: 200, width: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                        image: AssetImage('assets/gameoverscorescreen.png'),
                        fit: BoxFit.fitWidth)),
                // child: Padding(
                //   padding: const EdgeInsets.all(18.0),
                //   child: Row(
                //     children: [
                //       Column(
                //         children: [
                //           const Text(
                //             'MEDAL',
                //             style: TextStyle(color: Colors.orange),
                //           ),
                //           SizedBox(
                //             height: 10,
                //           ),
                //           Container(
                //             height: 50,
                //             width: 50,
                //             decoration: const BoxDecoration(
                //                 shape: BoxShape.circle, color: Colors.black),
                //           ),
                //         ],
                //       ),
                //       const SizedBox(
                //         width: 50,
                //       ),
                //       const Column(
                //         children: [
                //           Text(
                //             'SCORE',
                //             style: TextStyle(color: Colors.orange),
                //           ),
                //           Text('1'),
                //           Text(
                //             'BEST',
                //             style: TextStyle(color: Colors.orange),
                //           ),
                //           Text('120')
                //         ],
                //       )
                //     ],
                //   ),
                // ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                },
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(
                      Colors.red), // specify the text color here
                  backgroundColor: MaterialStateProperty.all(
                      Colors.green), // specify the background color here
                ),
                child: const Text('RESTART'),
              ),
            ],
          ),
        );
      });
}
