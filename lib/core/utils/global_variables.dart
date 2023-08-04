import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sociogram/features/posts/add_post_screen.dart';
import 'package:sociogram/features/feeds/feeds_screen.dart';
import 'package:sociogram/features/profile/profile_screen.dart';
import 'package:sociogram/features/search/search_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedsScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid),
];
