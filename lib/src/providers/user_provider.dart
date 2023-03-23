import 'package:flutter/widgets.dart';

import '../models/user.dart';
import '../resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethod _authMethods = AuthMethod();

  Future<void> refreshUser() async {
    _user = await _authMethods.getUserDetails();
    notifyListeners();
  }

  User? get getUser => _user;
}
