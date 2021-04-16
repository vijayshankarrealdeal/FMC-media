import 'dart:io';

import 'package:tflite/tflite.dart';

class AiEngine {
  Future<void> loadModel() async {
    String res = await Tflite.loadModel(
        model: "assets/model.tflite",
        labels: "assets/labels.txt",
        numThreads: 2, // defaults to 1
        isAsset:
            true, // defaults to true, set to false to load resources outside assets
        useGpuDelegate:
            false // defaults to false, set to true to use GPU delegate
        );
    print(res);
  }

  Future<List> runModel(File asset) async {
    List<dynamic> recognitions = await Tflite.runModelOnImage(
        path: asset.path, // required
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 2, // defaults to 5
        threshold: 0.2, // defaults to 0.1
        asynch: true // defaults to true
        );
    print(recognitions);
    return recognitions;
  }
}
