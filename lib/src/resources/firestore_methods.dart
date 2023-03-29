import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/src/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

import '../models/post.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload Post
  Future<String> uploadPost(String description, Uint8List file, String uid, String username, String profImage) async {
    String res = 'Some error Occurred';
    try {
      String photoUrl = await StorageMethods().uploadImageToStorage('posts', file, true);

      String postId = const Uuid().v1();
      Post post = Post(
          uid: uid,
          description: description,
          postId: postId,
          datePublished: DateTime.now().toString(),
          postUrl: photoUrl,
          profImage: profImage,
          likes: [],
          username: username);

      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = 'success';
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

  Future likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      throw (e.toString());
    }
  }
}
