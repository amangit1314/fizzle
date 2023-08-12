import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../posts/widgets/post_card.dart';

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
            icon: const Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: FaIcon(FontAwesomeIcons.bell),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: FaIcon(FontAwesomeIcons.comment),
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
