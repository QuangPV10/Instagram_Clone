import 'package:flutter/material.dart';
import 'package:instagram_clone/src/models/user.dart' as model;
import 'package:instagram_clone/src/providers/user_provider.dart';
import 'package:provider/provider.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  @override
  Widget build(BuildContext context) {
    final model.User? user = Provider.of<UserProvider>(context).getUser;

    return user == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            body: Center(
              child: Text(user.username),
            ),
          );
  }
}
