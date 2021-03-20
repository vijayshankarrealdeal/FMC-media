import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

class StorageX extends ChangeNotifier {
  final _refrence = FirebaseStorage.instance;

  Future<void> uploadExample(File file) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String filePath = '${appDocDir.absolute}/$file';
    try {
      await _refrence.ref(filePath).putFile(file);
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }
}
