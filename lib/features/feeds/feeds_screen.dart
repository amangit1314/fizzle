import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sociogram/core/utils/colors.dart';

import '../../core/widgets/post_card.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff051726),
      appBar: AppBar(
        elevation: 0,
       backgroundColor: const Color(0xff051726),
        title: ShaderMask(
          shaderCallback: (bounds) => const RadialGradient(
            center: Alignment.topLeft,
            radius: 1.0,
            colors: <Color>[
              Color(0xff81ffd9),
              Color(0xff39cff2),
            ],
            tileMode: TileMode.mirror,
          ).createShader(bounds),
          child: const Text(
            'Sociogram',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: const FaIcon(FontAwesomeIcons.bell),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: const FaIcon(FontAwesomeIcons.comment),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('posts').snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    itemCount: snapshot.data?.docs.length ?? 0,
                    itemBuilder: (context, index) {
                      return PostCard(snap: snapshot.data!.docs[index].data());
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedGradientText extends StatefulWidget {
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
      duration: const Duration(microseconds: 1000), // Set the duration to 10 seconds
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
              ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
          ),
        );
      },
    );
  }
}


// gradient text class
