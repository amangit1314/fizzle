import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/models/posts.dart';
import 'package:instagram_clone/resources/storage_methods.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//PostModel postModel
// Upload Post
  Future<void> uploadPost(
      String description, Uint8List file, String uid, String username) async {
    String res = "some error occured";

    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        datePublished: Date.now(),
      );
    } catch (e) {}
    final CollectionReference reference = _firestore.collection('posts');
    // reference.add(postModel.toMap());
  }
}
