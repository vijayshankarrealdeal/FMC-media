class StudentUpload {
  final String uploadUrl;
  final String time;
  final String uid;
  final String imagesId;
  final String name;
  final String email;
  final Map<String,bool> likes;

   StudentUpload({this.name,this.email,this.likes,this.uploadUrl, this.time, this.uid, this.imagesId});

  Map<String, dynamic> toJson() {
    return {
      'name':name,
      'email':email,
      'likes':likes,
      'uid': uid,
      'uploadUrl': uploadUrl,
      'time': time,
      'imagesId': imagesId,
    };
  }
}
 