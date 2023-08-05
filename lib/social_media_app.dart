import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sociogram/core/providers/user_provider.dart';

import 'package:sociogram/features/auth/login/login_screen.dart';
import 'package:sociogram/core/utils/colors.dart';
import 'package:provider/provider.dart';

import 'features/responsive/mobile_screen_layout.dart';
import 'features/responsive/responsive_layout.dart';
import 'features/responsive/web_screen_layout.dart';

class SocialMediaApp extends StatelessWidget {
  const SocialMediaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        title: 'Sociogram',
        debugShowCheckedModeBanner: false,
        
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
          primaryColor: const Color(0xff81ffd9),
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }

            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
