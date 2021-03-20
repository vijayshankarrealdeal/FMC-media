class StudentDetails {
  final String uid;
  final String email;
  final String classroomID;
  final String dob;
  final String gender;
  final String name;
  final String phoneNumber;

  final bool firstTime;
  StudentDetails({
    this.uid,
    this.email,
    this.firstTime,
    this.classroomID,
    this.dob,
    this.gender,
    this.name,
    this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'firstTime': firstTime,
      'email': email,
      'dob': dob,
      'gender': gender,
      'name': name,
      'phoneNumber': phoneNumber,
      'classroomID': classroomID
    };
  }

  factory StudentDetails.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    } else {
      return StudentDetails(
        uid: data['uid'] ?? '',
        firstTime: data['firstTime'] == null ? false : data['firstTime'],
        email: data['email'] == null ? '' : data['email'],
        dob: data['dob'] == null ? '' : data['dob'],
        gender: data['gender'] == null ? '' : data['gender'],
        name: data['name'] == null ? '' : data['name'],
        phoneNumber: data['phoneNumber'] == null ? '' : data['phoneNumber'],
        classroomID: data['classroomID'] == null ? '' : data['classroomID'],
      );
    }
  }
}
