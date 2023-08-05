// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatelessWidget {
  final snap;
  const CommentCard({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(snap.data()['profilePic']),
            radius: 18,
            backgroundColor: Color(0xff81ffd9),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: snap.data()['name'] + ' ',
                          style: GoogleFonts.comfortaa(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 14,
                          )
                        ),
                        
                        TextSpan(
                          text: DateFormat.yMMMd().format(
                            snap.data()['datePublished'].toDate(),
                          ),
                          style: GoogleFonts.comfortaa(
                            color: Colors.grey,
                            fontSize: 12,
                          )
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      '${snap.data()['text']}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: const Icon(
              Icons.favorite_border_outlined,
              size: 18,
              color: Colors.white38,
            ),
          )
        ],
      ),
    );
  }
}
