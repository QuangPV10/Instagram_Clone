import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String username;
  final String photoUrl;
  final String email;
  final String bio;
  final List followers;
  final List following;

  const User(
      {required this.uid,
      required this.email,
      required this.bio,
      required this.followers,
      required this.following,
      required this.photoUrl,
      required this.username});

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'emaul': email,
        'bio': bio,
        'followers': [],
        'following': [],
        'photoUrl': photoUrl
      };

  static User fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
        uid: snapshot['uid'],
        email: snapshot['emaul'],
        bio: snapshot['bio'],
        followers: snapshot['followers'],
        following: snapshot['following'],
        photoUrl: snapshot['photoUrl'],
        username: snapshot['username']);
  }
}
