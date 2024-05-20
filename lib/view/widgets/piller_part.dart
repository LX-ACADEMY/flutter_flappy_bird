import 'package:flutter/material.dart';

class PillerPart extends StatelessWidget {
  const PillerPart({super.key});

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
                  height: 100,
                  color: const Color.fromARGB(255, 234, 111, 4),
                ),
                const Spacer(),
                Container(
                  width: 100,
                  height: 200,
                  color: const Color.fromARGB(255, 234, 111, 4),
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
            width: 100,
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
