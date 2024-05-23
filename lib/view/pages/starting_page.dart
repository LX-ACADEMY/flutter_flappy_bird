import 'package:flappy_bird/view/pages/home_page.dart';
import 'package:flutter/material.dart';

class StartingPage extends StatelessWidget {
  const StartingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      },
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/starting page.png"),
                fit: BoxFit.cover)),
      ),
    );
  }
}
