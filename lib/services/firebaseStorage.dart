import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
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

  Future<Uint8List> testComporessList(Uint8List list) async {
    var result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 500,
      minWidth: 500,
      quality: 87,
    );
    print(list.length);
    print(result.length);
    return result;
  }

  Future<String> saveImage(Asset asset) async {
    String url = '';
    ByteData byteData =
        await asset.getByteData(); // requestOriginal is being deprecated
    List<int> imageData = byteData.buffer.asUint8List();

    Reference ref = _refrence.ref().child(DateTime.now()
        .toString()); // To be aligned with the latest firebase API(4.0)
    UploadTask uploadTask = ref.putData(imageData);
    uploadTask.whenComplete(() async {
      url = await ref.getDownloadURL();
    }).catchError((onError) {
      print(onError);
    });
    return url;
  }
}
