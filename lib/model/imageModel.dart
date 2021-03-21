class LeaderBoardModel {
  final String uploadUrl;
  final String time;
  final String uid;
  final String imagesId;

  LeaderBoardModel({this.uploadUrl, this.time, this.uid, this.imagesId});
  factory LeaderBoardModel.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    } else {
      return LeaderBoardModel(
        uploadUrl: data['uploadUrl'] ?? '',
        uid: data['uid'] ?? '',
        time: data['time'] ?? '',
        imagesId: data['imagesId'] ?? '',
      );
    }
  }
}
