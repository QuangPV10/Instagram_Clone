import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/src/responsive/responsive_layout.dart';
import 'package:instagram_clone/src/responsive/web_screen_layout.dart';
import 'package:instagram_clone/src/screens/login_screen.dart';
import 'package:instagram_clone/src/share/constant.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      title: 'Instagram Clone',
      // home: const ResponsiveLayout(mobileScreenLayout: MobileScreenLayout(), webScreenLayout: WebScreenLayout()),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(), webScreenLayout: WebScreenLayout());
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }

          return const LoginScreen();
        },
      ),
    );
  }
}
