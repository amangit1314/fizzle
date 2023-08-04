import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sociogram/features/auth/login_screen.dart';
import 'package:sociogram/core/services/firebase/auth/auth_methods.dart';
import 'package:sociogram/core/utils/colors.dart';
import 'package:sociogram/core/utils/utils.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      // get post lENGTH
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      postLen = postSnap.docs.length;
      userData = userSnap.data()!;
      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['following'].length;
      isFollowing = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
    } catch (e) {
      if (!mounted) return;
      showSnackBar(
        context,
        e.toString(),
      );
    }
    if (!mounted) return;
    setState(() {
      if (!mounted) return;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : LoadedWidget(
            userData: userData,
            widget: widget,
            postLen: postLen,
            followers: followers,
            following: following,
          );
  }
}

class LoadedWidget extends StatelessWidget {
  const LoadedWidget({
    Key? key,
    required this.userData,
    required this.widget,
    required this.postLen,
    required this.followers,
    required this.following,
  }) : super(key: key);

  final Map userData;
  final ProfileScreen widget;
  final int postLen;
  final int followers;
  final int following;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff051726),
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Text(
          userData['username'] ?? 'Username',
          style: const TextStyle(fontSize: 16),
        ),
        centerTitle: false,
        actions: [
          if (FirebaseAuth.instance.currentUser!.uid == widget.uid)
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
                AuthMethods().signOut();
              },
              icon: const Icon(
                Icons.logout,
                size: 18,
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min, // Set mainAxisSize to min
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Remove Expanded from here
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(
                          userData['photoUrl'] ??
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQb1tOL7dhJvW18V_wWYtBMBOLZCyfFKjkIMsNaXyWI&s',
                        ),
                        radius: 40,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          BuildStatColumn(
                            num: postLen,
                            label: "posts",
                          ),
                          BuildStatColumn(
                            num: followers,
                            label: "followers",
                          ),
                          BuildStatColumn(
                            num: following,
                            label: "following",
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    userData['username'] ?? 'Username',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    userData['bio'] ?? 'Write bio here',
                    maxLines: 2,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
              height: 1,
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Story Highlights',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQb1tOL7dhJvW18V_wWYtBMBOLZCyfFKjkIMsNaXyWI&s',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.grey,
              height: 1,
            ),
            const SizedBox(height: 16),
            DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  const TabBar(
                    indicatorColor: Colors.white,
                    tabs: [
                      Tab(
                        icon: Icon(Icons.grid_on),
                      ),
                      Tab(
                        icon: Icon(Icons.video_collection),
                      ),
                    ],
                  ),
                  Container(
                    // Set a fixed height for the TabBarView content to avoid unbounded height error
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: TabBarView(
                      children: [
                        FutureBuilder<QuerySnapshot>(
                          future: FirebaseFirestore.instance
                              .collection('posts')
                              .where('uid', isEqualTo: widget.uid)
                              .get(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.hasError) {
                              return const Center(
                                child: Text('Error fetching posts.'),
                              );
                            }

                            return GridView.builder(
                              itemCount: snapshot.data!.docs.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 1.5,
                                childAspectRatio: 1,
                              ),
                              itemBuilder: (context, index) {
                                DocumentSnapshot snap =
                                    snapshot.data!.docs[index];

                                return Container(
                                  padding: const EdgeInsets.all(0),
                                  child: Image.network(
                                    snap['postUrl'] ??
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQb1tOL7dhJvW18V_wWYtBMBOLZCyfFKjkIMsNaXyWI&s',
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        const Center(
                          child: Text('Video Collection'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildStatColumn extends StatelessWidget {
  const BuildStatColumn({
    Key? key,
    required this.num,
    required this.label,
  }) : super(key: key);

  final int num;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
