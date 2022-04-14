// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_variables.dart';
// import 'package:instagram_clone/providers/user_provider.dart';
// import 'package:provider/provider.dart';
// import '././../models/user.dart' as model;

class MobileScreen extends StatefulWidget {
  const MobileScreen({Key? key}) : super(key: key);

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    // model.User user = Provider.of<UserProvider>(context, listen: false).getUser;
    return Scaffold(
      body: PageView(
        children: homeScreenItems,
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        onTap: navigationTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.home,
              color: _page == 0 ? primaryColor : secondaryColor,
            ),
            //label: 'Home',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.search,
              color: _page == 1 ? primaryColor : secondaryColor,
            ),
            //label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.add,
              color: _page == 2 ? primaryColor : secondaryColor,
            ),
            //label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: _page == 3 ? primaryColor : secondaryColor,
            ),
            //label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.person,
              color: _page == 4 ? primaryColor : secondaryColor,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
