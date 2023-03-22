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
      home: const LoginScreen(),
    );
  }
}
