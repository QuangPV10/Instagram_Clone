import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/screens/profile_screen.dart';
import 'package:instagram_clone/src/share/constant.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();
  bool isShowUser = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: Form(
            child: TextFormField(
              controller: searchController,
              decoration: const InputDecoration(hintText: 'Search for a User'),
              onFieldSubmitted: (value) {
                setState(() {
                  isShowUser = true;
                });

                if (value.isEmpty) {
                  setState(() {
                    isShowUser = false;
                  });
                }
              },
            ),
          ),
        ),
        body: isShowUser
            ? FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .where('username', isGreaterThanOrEqualTo: searchController.text)
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemCount: (snapshot.data! as dynamic).docs.length,
                    itemBuilder: (context, index) {
                      final user = (snapshot.data! as dynamic).docs[index];
                      return InkWell(
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProfileScreen(uid: user['uid']),
                        )),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(user['photoUrl']),
                          ),
                          title: Text(user['username']),
                        ),
                      );
                    },
                  );
                },
              )
            : Container()

        // FutureBuilder(
        //     future: FirebaseFirestore.instance.collection('posts').get(),
        //     builder: (context, snapshot) {
        //       if (!snapshot.hasData) {
        //         return const Center(
        //           child: CircularProgressIndicator(),
        //         );
        //       }

        //       return StaggeredGridView.countBuilder(
        //         crossAxisCount: 3,
        //         itemCount: (snapshot.data! as dynamic).docs.length,
        //         itemBuilder: (context, index) => Image.network(
        //           (snapshot.data! as dynamic).docs[index]['postUrl'],
        //           fit: BoxFit.cover,
        //         ),
        //         staggeredTileBuilder: (index) => MediaQuery.of(context).size.width > webScreenSize
        //             ? StaggeredTile.count((index % 7 == 0) ? 1 : 1, (index % 7 == 0) ? 1 : 1)
        //             : StaggeredTile.count((index % 7 == 0) ? 2 : 1, (index % 7 == 0) ? 2 : 1),
        //         mainAxisSpacing: 8.0,
        //         crossAxisSpacing: 8.0,
        //       );
        //     },
        //   ),
        );
  }
}
