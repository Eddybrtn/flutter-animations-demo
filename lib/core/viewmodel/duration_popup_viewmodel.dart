import 'package:flutter/material.dart';

class DurationPopupViewModel extends ChangeNotifier {
  double durationInSeconds;

  DurationPopupViewModel(this.durationInSeconds);

  void updateDuration(double duration) {
    durationInSeconds = duration;
    notifyListeners();
  }
}