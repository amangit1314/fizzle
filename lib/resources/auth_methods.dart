import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/models/user.dart' as model;
import 'package:instagram_clone/resources/storage_methods.dart';

// A class holding auth methods
class AuthMethods {
  // Firebase auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Firebase firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // a future method to get user derails from firebase
  Future<model.User> getUserDetails() async {
    // getting the current user from firebase auth
    User currentUser = _auth.currentUser!;
    // getting the user details from firestore
    final DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();
    // creating a user model from the snapshot
    return model.User.fromSnap(snap);
  }

  // a future method to register the user from firebase
  Future<String> registerUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          // ignore: unnecessary_null_comparison
          file != null) {
        //  register user using firebase method {createUserWithEmailAndPassword}
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('postPics', file, false);

        model.User user = model.User(
          bio: bio,
          email: email,
          username: username,
          photoUrl: photoUrl,
          uid: cred.user!.uid,
          followers: [],
          following: [],
        );

        //  add user to our database
        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
        res = 'success';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = '❗The email is badly formated...';
      } else if (err.code == 'weak-password') {
        res = 'Password should be 6 characters long...';
      }
    } catch (err) {
      res = res.toString();
    }
    return res;
  }

  // to login the user
  Future<String> loginUser({required email, required password}) async {
    String res = "❓error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = '❗Please enter both email and password';
      }
    } catch (err) {
      res = res.toString();
    }
    return res;
  }

  // to logout the user
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
