import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../features/feeds/feeds_screen.dart';
import '../../features/posts/add_post_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/search/search_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedsScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid),
];
