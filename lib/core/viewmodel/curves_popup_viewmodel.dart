import 'package:flutter/material.dart';

class CurvesPopupViewModel extends ChangeNotifier {
  Curve curve;

  CurvesPopupViewModel(this.curve);

  void updateCurve(Curve curve) {
    this.curve = curve;
    notifyListeners();
  }
}
