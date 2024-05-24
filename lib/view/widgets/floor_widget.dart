import 'package:flutter/material.dart';

class FloorWidget extends StatelessWidget {
  const FloorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 100,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/floor.png"), fit: BoxFit.fill)));
  }
}
