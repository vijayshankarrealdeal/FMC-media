class StudentUpload {
  final String uploadUrl;
  final String time;
  final String uid;
  final String imagesId;

  StudentUpload({this.uploadUrl, this.time, this.uid, this.imagesId});

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'uploadUrl': uploadUrl,
      'time': time,
      'imagesId': imagesId,
    };
  }
}
 