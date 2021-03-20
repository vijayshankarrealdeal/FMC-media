class Notificationxx {
  final String title;
  final String subTitle;
  final String details;
  final String deadLine;

  Notificationxx({this.title, this.subTitle, this.details, this.deadLine});
  factory Notificationxx.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    } else {
      return Notificationxx(
        title: data['title'] ?? '',
        subTitle: data['subTitle'] ?? '',
        details: data['details'] ?? '',
        deadLine: data['deadLine'] ?? '',
      );
    }
  }
}
