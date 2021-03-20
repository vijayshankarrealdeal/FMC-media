import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fmc/model/admin.dart';
import 'package:fmc/model/studentDetail.dart';

class Database extends ChangeNotifier {
  Database({@required this.uid, @required this.email});
  final String uid;
  final String email;

  final _dbrefrence = FirebaseFirestore.instance;

  //  Create user
  Future<void> createStudent(StudentDetails data) async {
    await _dbrefrence.collection('student').doc(uid).set(data.toJson());
    notifyListeners();
  }

  Stream<List<StudentDetails>> studentallDetails() {
    return _dbrefrence
        .collection('student')
        .where("uid", isEqualTo: uid)
        .limit(1)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => StudentDetails.fromMap(e.data())).toList());
  }

  Stream<List<AdminControl>> adminXD() {
    return _dbrefrence.collection('admin').snapshots().map((event) =>
        event.docs.map((e) => AdminControl.fromJson(e.data())).toList());
  }
}
