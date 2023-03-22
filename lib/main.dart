import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyCn6qKvsRsFTMt2U8JjmWnW8gUT5Hp-WAk',
            appId: '1:27186963541:web:dfb1a3964078b1b28ea0dc',
            messagingSenderId: '27186963541',
            projectId: 'instagram-clone-3b3b7',
            storageBucket: 'instagram-clone-3b3b7.appspot.com'));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}
