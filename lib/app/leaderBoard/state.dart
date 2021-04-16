import 'package:flutter/foundation.dart';
import 'package:fmc/services/database.dart';

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
