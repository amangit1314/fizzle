import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String postId;
  final String username;
  final String datePublished;
  final List postUrl;
  final List profileImage;
  final List likes;

  const Post(
    this.description,
    this.postId,
    this.datePublished,
    this.postUrl,
    this.profileImage,
    this.likes, {
    required this.uid,
    required this.username,
  });

  Map<String, dynamic> toJson() => {
        'description': description,
        'uid': uid,
        'postUrl': postUrl,
        'username': username,
        'datePublished': datePublished,
        'likes': likes,
        'postId': postId,
        'profileImage': profileImage,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
      email: snapshot['email'] as String,
      uid: snapshot['uid'] as String,
      photoUrl: snapshot['photoUrl'] as String,
      username: snapshot['username'] as String,
      bio: snapshot['bio'] as String,
      followers: snapshot['followers'] as List,
      following: snapshot['following'] as List,
    );
  }
}
