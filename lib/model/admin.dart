class AdminControl {
  final bool isAnyComp;
  final List adminList;

  AdminControl({this.isAnyComp, this.adminList});
  factory AdminControl.fromJson(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    } else {
      return AdminControl(
        isAnyComp: data['isAnyComp'] ?? false,
        adminList: data['adminList'] ?? [],
      );
    }
  }
}
