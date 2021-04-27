class Notificationxx {
  final String title;
  final String subTitle;
  final String details;
  final bool isEventOver;

  Notificationxx({this.title, this.subTitle, this.details, this.isEventOver});
  factory Notificationxx.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    } else {
      return Notificationxx(
        title: data['title'] ?? '',
        subTitle: data['subTitle'] ?? '',
        details: data['details'] ?? '',
        isEventOver: data['isEventOver'] ?? false,
      );
    }
  }
}
