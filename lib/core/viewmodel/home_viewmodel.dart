import 'package:flutter/material.dart';
import 'package:introducing_animations/ui/screens/curves_popup.dart';
import 'package:introducing_animations/ui/screens/duration_popup.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel(this.tickerProvider) {
    initExplicitAnimation();
  }

  TickerProvider tickerProvider;
  late AnimationController _animationController;

  // Explicit animations
  late Animation<double> opacityAnimation;
  late Animation<double> rotationAnimation;
  late Animation<double> scaleAnimation;
  late Animation<Color?> colorAnimation;
  late Animation<Alignment> alignmentAnimation;
  late Animation<double> sizeAnimation;

  Curve curve = Curves.linear;
  Duration duration = kThemeAnimationDuration;

  double get durationInSeconds => duration.inMilliseconds / 1000;

  double animatedPadding = 16;
  double animatedTurns = 0;
  double animatedOpacity = 1;
  double animatedSlideX = 0;
  double animatedScale = 1;
  bool _isDefaultTextStyle = true;
  bool _isDefaultContainer = true;
  int _positionStatus = 0;
  bool isDefaultAnimatedSwitcher = true;

  double get animatedContainerRadius => _isDefaultContainer ? 0 : 10;

  double get animatedContainerBorderWidth => _isDefaultContainer ? 2 : 4;

  Alignment get animatedContainerAlignment =>
      _isDefaultContainer ? Alignment.centerLeft : Alignment.centerRight;

  Color get animatedContainerColor =>
      _isDefaultContainer ? Colors.blue : Colors.red;

  Color get animatedContainerBorderColor =>
      _isDefaultContainer ? Colors.black : Colors.blue;

  double animatedPositionTop = 0;

  double animatedPositionLeft = 0;

  void initExplicitAnimation() {
    _animationController = AnimationController(
        vsync: tickerProvider, duration: const Duration(seconds: 4));
    _animationController.addListener(() {
      notifyListeners();
    });

    opacityAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: const Interval(0, 0.1)));

    rotationAnimation = Tween<double>(begin: 0, end: 2).animate(CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.4, 0.6, curve: Curves.ease)));

    scaleAnimation = Tween<double>(begin: 1, end: 2).animate(CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 0.7, curve: Curves.elasticIn)));

    sizeAnimation = Tween<double>(begin: 200, end: 90).animate(CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 0.7, curve: Curves.elasticIn)));

    colorAnimation = ColorTween(begin: Colors.red, end: Colors.green).animate(
        CurvedAnimation(
            parent: _animationController, curve: const Interval(0.6, 0.8)));

    alignmentAnimation =
        Tween<Alignment>(begin: Alignment.topCenter, end: Alignment.bottomCenter)
            .animate(CurvedAnimation(
                parent: _animationController,
                curve: const Interval(0, 1, curve: Curves.bounceOut)));
  }

  void startExplicitAnimation() {
    _animationController.forward();
  }

  void pauseExplicitAnimation() {
    _animationController.stop();
  }

  void revertExplicitAnimation() {
    _animationController.reverse();
  }

  TextStyle get animatedTextStyle {
    if (_isDefaultTextStyle) {
      return const TextStyle(
          color: Colors.blue,
          fontSize: 16,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal);
    } else {
      return const TextStyle(
          color: Colors.red,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic);
    }
  }

  void animateTurns() {
    animatedTurns += 0.5;
    notifyListeners();
  }

  void animatePadding() {
    if (animatedPadding == 16) {
      animatedPadding = 48;
    } else {
      animatedPadding = 16;
    }
    notifyListeners();
  }

  void animateTextStyle() {
    _isDefaultTextStyle = !_isDefaultTextStyle;
    notifyListeners();
  }

  void animateOpacity() {
    if (animatedOpacity == 1) {
      animatedOpacity = 0.5;
    } else {
      animatedOpacity = 1;
    }
    notifyListeners();
  }

  void animateContainer() {
    _isDefaultContainer = !_isDefaultContainer;
    notifyListeners();
  }

  void animateSlide() {
    if (animatedSlideX == 0) {
      animatedSlideX = 0.5;
    } else {
      animatedSlideX = 0;
    }
    notifyListeners();
  }

  void animatePosition() {
    _positionStatus++;
    if (_positionStatus % 3 == 0) {
      animatedPositionLeft = 0;
      animatedPositionTop = 0;
    } else if (_positionStatus % 3 == 1) {
      animatedPositionLeft = 120;
      animatedPositionTop = 50;
    } else if (_positionStatus % 3 == 2) {
      animatedPositionLeft = 200;
      animatedPositionTop = 0;
    }
    notifyListeners();
  }

  void animateSwitcher() {
    isDefaultAnimatedSwitcher = !isDefaultAnimatedSwitcher;
    notifyListeners();
  }

  void animateScale() {
    if (animatedScale == 1) {
      animatedScale = 2;
    } else {
      animatedScale = 1;
    }
    notifyListeners();
  }

  void updateAnimationCurve(Curve curve) {
    this.curve = curve;
    notifyListeners();
  }

  void updateAnimationDuration(double seconds) {
    duration = Duration(milliseconds: (seconds * 1000).toInt());
    notifyListeners();
  }

  void showDurationPopup(BuildContext context) async {
    var result = await showDialog(
        context: context,
        builder: (context) => DurationPopup(duration: durationInSeconds));
    if (result != null && result is double) {
      updateAnimationDuration(result);
    }
  }

  void showCurvesPopup(BuildContext context) async {
    var result = await showDialog(
        context: context, builder: (context) => CurvesPopup(curve));
    if (result != null && result is Curve) {
      updateAnimationCurve(result);
    }
  }
}
