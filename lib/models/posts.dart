import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String postId;
  final String username;
  final datePublished;
  final String postUrl;
  final String profileImage;
  final List likes;

  const Post({
    required this.description,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profileImage,
    required this.likes,
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
      description: snapshot['description'] as String,
      uid: snapshot['uid'] as String,
      postUrl: snapshot['postUrl'] as String,
      username: snapshot['username'] as String,
      datePublished: snapshot['bio'] as String,
      likes: snapshot['likes'] as List,
      postId: snapshot['postId'] as String,
      profileImage: snapshot['profileImage'] as String,
    );
  }
}
