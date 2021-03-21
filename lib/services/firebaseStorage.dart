import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';

class StorageX extends ChangeNotifier {
  final _refrence = FirebaseStorage.instance;
  double percent = 0;
  bool uploadStart = false;
  List uploadUrlX = [];

  Future<void> uploadExample(File file) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String filePath = '${appDocDir.absolute}/$file';
    try {
      await _refrence.ref(filePath).putFile(file);
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  void uploadTaskBegin() {
    uploadStart = !uploadStart;
    notifyListeners();
  }

  Future<void> saveImage(Asset asset) async {
    ByteData byteData =
        await asset.getByteData(); // requestOriginal is being deprecated
    List<int> imageData = byteData.buffer.asUint8List();

    Reference ref = _refrence.ref().child(DateTime.now().toString());
    UploadTask uploadTask = ref.putData(imageData);
    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      percent = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
      percent.round().toString() == "100" ? uploadStart = false : print('');
      notifyListeners();
    });
    uploadTask.whenComplete(() async {
      var uploadUrl = await ref.getDownloadURL();
      uploadUrlX.add(uploadUrl);
      notifyListeners();
    }).catchError((onError) {
      uploadStart = false;
    });
  }
}
