import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String username;
  final String postId;
  final dataPublished;
  final String postURL;
  final String profileImage;
  final likes;

  const Post(
      {required this.description,
      required this.uid,
      required this.username,
      required this.postId,
      required this.dataPublished,
      required this.postURL,
      required this.profileImage,
      required this.likes});

  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "username": username,
        "postId": postId,
        "dataPublished": dataPublished,
        "postURL": postURL,
        "profileImage": profileImage,
        "likes": likes,
      };

  static Post fromSnap(DocumentSnapshot snapshot) {
    var snap = (snapshot.data() as Map<String, dynamic>);

    return Post(
      description: snap["description"],
      uid: snap["uid"],
      username: snap["username"],
      postId: snap["postId"],
      dataPublished: snap["dataPublished"],
      postURL: snap["postURL"],
      profileImage: snap["profileImage"],
      likes: snap["likes"],
    );
  }
}
