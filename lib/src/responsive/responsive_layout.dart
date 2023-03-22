import 'package:flutter/material.dart';
import 'package:instagram_clone/src/utils/dimension.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  const ResponsiveLayout({required this.mobileScreenLayout, required this.webScreenLayout, super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScrenSize) {
          return webScreenLayout;
        }
        return mobileScreenLayout;
      },
    );
  }
}
