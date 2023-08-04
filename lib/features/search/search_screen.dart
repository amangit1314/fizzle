import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sociogram/features/profile/profile_screen.dart';

import '../../core/utils/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff051726),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isShowUsers = true;
              });
            },
            child: Container(
              height: 70,
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Form(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: TextFormField(
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        controller: searchController,
                        decoration: const InputDecoration(
                          hintText: 'Search for a user...',
                          hintStyle: TextStyle(
                            color: Colors.white54,
                          ),
                          border: InputBorder.none,
                        ),
                        onFieldSubmitted: (String _) {
                          setState(() {
                            isShowUsers = true;
                          });
                        },
                      ),
                    ),
                    const Icon(
                      Icons.search,
                      color: Color(0xff81ffd9),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          isShowUsers
              ? FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .where(
                        'username',
                        isGreaterThanOrEqualTo: searchController.text,
                      )
                      .get(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return _buildShimmerBoxes();
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            top: 15.0,
                            left: 15,
                          ),
                          child: Text(
                            'Available users',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Flexible(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: (snapshot.data! as dynamic).docs.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ProfileScreen(
                                      uid: (snapshot.data! as dynamic)
                                          .docs[index]['uid'],
                                    ),
                                  ),
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      (snapshot.data! as dynamic).docs[index]
                                          ['photoUrl'],
                                    ),
                                    radius: 16,
                                  ),
                                  title: Text(
                                    (snapshot.data! as dynamic).docs[index]
                                        ['username'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                )
              : FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('posts')
                      .orderBy('datePublished')
                      .get(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return _buildShimmerBoxes();
                    }

                    return const Center(
                      child: Text(
                        'Grid',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }

  Widget _buildShimmerBoxes() {
    return Expanded(
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(0.5),
            highlightColor: Colors.grey.withOpacity(0.2),
            child: Container(
              height: 60,
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        },
      ),
    );
  }
}
