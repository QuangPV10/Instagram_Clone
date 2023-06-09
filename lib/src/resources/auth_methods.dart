import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/src/models/user.dart' as model;
import 'package:instagram_clone/src/resources/storage_methods.dart';

class AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snapshot = await _firestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnapshot(snapshot);
  }

  // sign up user
  Future<String> signUpUser(
      {required String username,
      required Uint8List file,
      required String email,
      required String password,
      required String bio}) async {
    String res = 'Some error occurred';
    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty || bio.isNotEmpty) {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

        String photoUrl = await StorageMethods().uploadImageToStorage('profilePics', file, false);

        model.User user = model.User(
            uid: userCredential.user!.uid,
            email: email,
            bio: bio,
            followers: [],
            following: [],
            photoUrl: photoUrl,
            username: username);

        await _firestore.collection('users').doc(userCredential.user!.uid).set(user.toJson());

        res = 'success';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'The email is badly formatted';
      } else if (err.code == 'weak-password') {
        res = 'Password should be at least 6 character';
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

  // sign in user
  Future<String> signInUser({required String email, required String password}) async {
    String res = 'Some error occurred';

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res = 'success';
      } else {
        res = 'Pleasse Enter All The Fields';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //sign ou
  Future signOut() async {
    await _auth.signOut();
  }
}
