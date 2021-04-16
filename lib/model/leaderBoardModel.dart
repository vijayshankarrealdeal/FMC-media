class LeaderBoardModel {
  final String uploadUrl;
  final String time;
  final String uid;
  final String imagesId;
  final String fisrt;
  final String email;
  final String name;
  final Map<String, dynamic> likes;
  final String second;
  final String third;
  final String fourth;

  LeaderBoardModel(
      {this.uploadUrl,
      this.fisrt,
      this.second,
      this.third,
      this.email,
      this.name,
      this.likes,
      this.fourth,
      this.time,
      this.uid,
      this.imagesId});
  factory LeaderBoardModel.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    } else {
      return LeaderBoardModel(
        email: data['email'] ?? "",
        name: data['name'] ?? "",
        likes: data['likes'] ?? {},
        uploadUrl: data['uploadUrl'] ?? '',
        uid: data['uid'] ?? '',
        time: data['time'] ?? '',
        imagesId: data['imagesId'] ?? '',
        fisrt: data['0'] ?? '',
        second: data['1'] ?? '',
        third: data['2'] ?? '',
        fourth: data['3'] ?? '',
      );
    }
  }
}
