class Likes {
  final String uid;
  final String imageId;

  Likes({this.uid, this.imageId});

  Map<String, dynamic> toJson() {
    return {
      'imageId': imageId,
      'uid': uid,
    };
  }

  factory Likes.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    } else {
      return Likes(
        imageId: data['imageId'] ?? '',
        uid: data['uid'] ?? '',
      );
    }
  }
}
