import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sociogram/models/user.dart';
import 'package:sociogram/core/services/firebase/auth/auth_methods.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user ?? const User(
    bio: '', email: '', 
  username: '',
  uid: '',
  photoUrl: '',
  followers: [],
  following: []
  );

  Future<void> refreshUser() async {
    User? user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
