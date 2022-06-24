import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/resources/auth_methods.dart';

// A Change Notifier inherited State Class which can be used or listen at the same time at any place where the specified state in this class is required
class UserProvider with ChangeNotifier {
  User? _user;
  // creating object of the AuthMehods class
  final AuthMethods _authMethods = AuthMethods();

  // a getter to get the user from getUser method
  User get getUser => _user!;

  // a future method to refresh the user
  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
