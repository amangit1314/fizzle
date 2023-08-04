import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/utils/colors.dart';
import '../../core/utils/global_variables.dart';


class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  final ValueNotifier<int> _page = ValueNotifier<int>(0);
  PageController pageController = PageController();

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(), // Prevent swiping
              children: homeScreenItems,
              onPageChanged: (page) {
                _page.value = page;
              },
            ),
          ),
          Positioned(
            bottom: 25,
            left: 25,
            right: 25,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  height: 65,
                  padding: const EdgeInsets.only(top: 15.0, bottom: 15),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: ValueListenableBuilder<int>(
                    valueListenable: _page,
                    builder: (context, value, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              _page.value = 0;
                              pageController.jumpToPage(
                                  0); // Update page programmatically
                            },
                            child: FaIcon(
                              FontAwesomeIcons.photoFilm,
                              size: 24,
                              color: (value == 0) ? popColor : secondaryColor,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _page.value = 1;
                              pageController.jumpToPage(
                                  1); // Update page programmatically
                            },
                            child: FaIcon(
                              FontAwesomeIcons.magnifyingGlass,
                              size: 24,
                              color: (value == 1) ? popColor : secondaryColor,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _page.value = 2;
                              pageController.jumpToPage(
                                  2); // Update page programmatically
                            },
                            child: FaIcon(
                              FontAwesomeIcons.squarePlus,
                              size: 24,
                              color: (value == 2) ? popColor : secondaryColor,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _page.value = 3;
                              pageController.jumpToPage(
                                  3); // Update page programmatically
                            },
                            child: FaIcon(
                              FontAwesomeIcons.circleUser,
                              size: 24,
                              color: (value == 3) ? popColor : secondaryColor,
                            ),
                          ),
                        ],
                      );
                    },
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
