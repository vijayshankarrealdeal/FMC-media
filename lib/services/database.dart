import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fmc/model/admin.dart';
import 'package:fmc/model/leaderBoardModel.dart';
import 'package:fmc/model/likes.dart';
import 'package:fmc/model/notification.dart';
import 'package:fmc/model/searchMatchUser.dart';
import 'package:fmc/model/studentDetail.dart';
import 'package:fmc/model/studentUpload.dart';

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

  Future<void> addImages(StudentUpload data, String id) async {
    await _dbrefrence.collection('images').doc(id).set(data.toJson());
    notifyListeners();
  }
  Future<void> addNOTDATAImages(StudentUpload data, String id) async {
    await _dbrefrence.collection('notgood').doc(id).set(data.toJson());

  }

  Future<void> addLikes(Likes data, String imageId) async {
    await _dbrefrence
        .collection('likes')
        .doc(imageId)
        .collection('UserData')
        .doc(uid)
        .set(data.toJson());
    notifyListeners();
  }

  Future<void> disLikes(String imageId) async {
    await _dbrefrence
        .collection('likes')
        .doc(imageId)
        .collection('UserData')
        .doc(uid)
        .delete();
    notifyListeners();
  }

  Future<void> addImagesXX(String id, String url, String i) async {
    await _dbrefrence.collection('images').doc(id).update({'$i': url});
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

  Stream<List<SearchAndMatchUser>> filterStudent(String uidXX) {
    return _dbrefrence
        .collection('student')
        .where("uid", isEqualTo: uidXX)
        .limit(1)
        .snapshots()
        .map((event) => event.docs
            .map((e) => SearchAndMatchUser.fromMap(e.data()))
            .toList());
  }

  Stream<List<AdminControl>> adminXD() {
    return _dbrefrence.collection('admin').snapshots().map((event) =>
        event.docs.map((e) => AdminControl.fromJson(e.data())).toList());
  }

  Stream<List<Likes>> getLikes(String putImageId) {
    return _dbrefrence
        .collection('likes')
        .doc(putImageId)
        .collection('UserData')
        .snapshots()
        .map(
            (event) => event.docs.map((e) => Likes.fromMap(e.data())).toList());
  }

  Stream<List<Notificationxx>> noticf() {
    return _dbrefrence.collection('notifi').snapshots().map((event) =>
        event.docs.map((e) => Notificationxx.fromMap(e.data())).toList());
  }

  Stream<List<LeaderBoardModel>> leader() {
    return _dbrefrence.collection('images').snapshots().map((event) => event
        .docs
        .map((e) => LeaderBoardModel.fromMap(e.data()))
        .toList()
        .reversed
        .toList());
  }
}
