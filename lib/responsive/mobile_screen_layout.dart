import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_variables.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
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

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: PageView(
              controller: pageController,
              onPageChanged: onPageChanged,
              children: homeScreenItems,
            ),
          ),
          Positioned(
            bottom: 10,
            left: 25,
            right: 25,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  // margin: const EdgeInsets.only(left: 15, right: 15),
                  padding: const EdgeInsets.only(top: 15.0, bottom: 15),
                  // decoration radius 15
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            _page = 0; // Update the current page index
                          });
                        },
                        child: FaIcon(
                          FontAwesomeIcons.grip,
                          size: 23,
                          color: (_page == 0) ? primaryColor : secondaryColor,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _page = 1; // Update the current page index
                          });
                        },
                        child: FaIcon(
                          FontAwesomeIcons.magnifyingGlass,
                          size: 23,
                          color: (_page == 1) ? primaryColor : secondaryColor,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _page = 2; // Update the current page index
                          });
                        },
                        child: FaIcon(
                          FontAwesomeIcons.camera,
                          size: 23,
                          color: (_page == 2) ? primaryColor : secondaryColor,
                        ),
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     setState(() {
                      //       _page = 3; // Update the current page index
                      //     });
                      //   },
                      //   child: FaIcon(
                      //     FontAwesomeIcons.video,
                      //     size: 23,
                      //     color: (_page == 3) ? primaryColor : secondaryColor,
                      //   ),
                      // ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _page = 4; // Update the current page index
                          });
                        },
                        child: FaIcon(
                          FontAwesomeIcons.userAstronaut,
                          size: 23,
                          color: (_page == 4) ? primaryColor : secondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
