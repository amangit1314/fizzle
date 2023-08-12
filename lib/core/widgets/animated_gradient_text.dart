import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedGradientText extends StatefulWidget {
  const AnimatedGradientText({Key? key}) : super(key: key);

  @override
  State<AnimatedGradientText> createState() => _AnimatedGradientTextState();
}

class _AnimatedGradientTextState extends State<AnimatedGradientText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Color> _colors;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration:
          const Duration(microseconds: 1000), // Set the duration to 10 seconds
      vsync: this,
    )..repeat(reverse: true);
    _updateColors();
  }

  void _updateColors() {
    final random = Random();
    _colors = [
      Color.fromRGBO(
          random.nextInt(256), random.nextInt(256), random.nextInt(256), 1.0),
      Color.fromRGBO(
          random.nextInt(256), random.nextInt(256), random.nextInt(256), 1.0),
      Color.fromRGBO(
          random.nextInt(256), random.nextInt(256), random.nextInt(256), 1.0),
    ];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        _updateColors(); // Update colors in the loop
        return Text(
          'Sociogram',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            foreground: Paint()
              ..shader = LinearGradient(
                colors: _colors,
              ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
          ),
        );
      },
    );
  }
}
