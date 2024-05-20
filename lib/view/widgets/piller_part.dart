import 'dart:math';

import 'package:flutter/material.dart';

class PillerPart extends StatelessWidget {
  PillerPart({super.key});

  late double intValue;

  // var randomObject = Random();
  @override
  Widget build(BuildContext context) {
    double pillerFullWidth = MediaQuery.of(context).size.height - 300;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        if (index % 2 == 1) {
          return Container(
            height: double.infinity,
            color: Colors.transparent,
            width: 100,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: intValue =
                      Random().nextInt(pillerFullWidth.toInt()).toDouble(),
                  // child: Image.asset(
                  //   "assets/Pasted image (2).png",
                  //   fit: BoxFit.fill,
                  // ),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/Pasted image (2).png"),
                      fit: BoxFit.fitWidth,
                      alignment: FractionalOffset.bottomCenter,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  width: 100,
                  height: pillerFullWidth - intValue,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/Pasted image (3).png"),
                          fit: BoxFit.fitWidth,
                          alignment: FractionalOffset.topCenter)),
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
            width: 200,
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
