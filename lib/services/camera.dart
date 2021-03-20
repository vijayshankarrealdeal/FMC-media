import 'package:flutter/cupertino.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class PickImage extends ChangeNotifier {
  List<Asset> images = [];
  String errorx = '';
  List<Asset> resultList;
  String error;
  Future<void> loadAssets() async {
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 4,
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    images = resultList;
    if (images == null) {
      throw Exception("Choose a Imgae");
    }
    if (error == null) errorx = 'No Error Dectected';
    notifyListeners();
  }
}
