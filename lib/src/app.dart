import 'package:flutter/material.dart';
import 'package:instagram_clone/src/screens/home_screen.dart';
import 'package:instagram_clone/src/share/constant.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      title: 'Instagram Clone',
      home: const HomeScreen(),
    );
  }
}
