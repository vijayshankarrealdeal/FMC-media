import 'package:flutter/foundation.dart';

class StateHearShowS extends ChangeNotifier {
  bool isEnable = false;
  void show() {
    isEnable = !isEnable;
    notifyListeners();
    Future.delayed(Duration(milliseconds: 1000));
    isEnable = !isEnable;
    notifyListeners();
  }
}
