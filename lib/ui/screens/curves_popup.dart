import 'package:flutter/material.dart';
import 'package:introducing_animations/core/viewmodel/curves_popup_viewmodel.dart';
import 'package:provider/provider.dart';

class CurvesPopup extends StatelessWidget {
  final Curve curve;
  final List<Curve> curves = [
    Curves.linear,
    Curves.bounceIn,
    Curves.bounceOut,
    Curves.elasticIn,
    Curves.slowMiddle,
    Curves.decelerate,
    Curves.easeIn,
    Curves.easeOut,
    Curves.ease,
  ];
  final List<String> curvesTitle = [
    "Linear",
    "BounceIn",
    "BounceOut",
    "ElasticIn",
    "SlowMiddle",
    "Decelerate",
    "EaseIn",
    "EaseOut",
    "Ease"
  ];

  CurvesPopup(this.curve, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CurvesPopupViewModel(curve),
      child: Consumer<CurvesPopupViewModel>(
        builder: (context, CurvesPopupViewModel viewModel, child) =>
            AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Courbe de l'animation"),
              for (int i = 0; i < curves.length; i++)
                RadioListTile(
                  title: Text(curvesTitle[i]),
                  value: curves[i],
                  groupValue: viewModel.curve,
                  onChanged: (Curve? curve) {
                    if (curve != null) {
                      viewModel.updateCurve(curve);
                    }
                  },
                ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, viewModel.curve);
                  },
                  child: const Text("Valider"))
            ],
          ),
        ),
      ),
    );
  }
}
