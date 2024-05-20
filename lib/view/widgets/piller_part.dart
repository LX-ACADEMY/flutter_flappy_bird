import 'dart:math';

import 'package:flutter/material.dart';

class PillerPart extends StatelessWidget {
  // var randomObject = Random();

  PillerPart({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        if (index % 2 == 0) {
          return Container(
            height: double.infinity,
            color: Colors.transparent,
            width: 100,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  child: Image.asset(
                    "assets/Pasted image (2).png",
                    fit: BoxFit.fill,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 100,
                  height: 200,
                  child: Image.asset(
                    "assets/Pasted image (3).png",
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                    width: double.infinity,
                    height: 100,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/Pasted image.png"),
                            fit: BoxFit.fill))),
              ],
            ),
          );
        } else {
          return Container(
            height: double.infinity,
            width: 150,
            child: Column(
              children: [
                const Spacer(),
                Container(
                    width: double.infinity,
                    height: 100,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/Pasted image.png"),
                            fit: BoxFit.fill))),
              ],
            ),
          );
        }
      },
    );
  }
}
