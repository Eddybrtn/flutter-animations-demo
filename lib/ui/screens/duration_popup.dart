import 'package:flutter/material.dart';
import 'package:introducing_animations/core/viewmodel/duration_popup_viewmodel.dart';
import 'package:provider/provider.dart';

class DurationPopup extends StatelessWidget {
  final double duration;

  const DurationPopup({Key? key, required this.duration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DurationPopupViewModel(duration),
      child: Consumer<DurationPopupViewModel>(
        builder: (context, DurationPopupViewModel viewModel, child) =>
            AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Durée de l'animation"),
              Slider(
                value: viewModel.durationInSeconds,
                onChanged: (value) {
                  viewModel.updateDuration(value);
                },
                min: 0.2,
                max: 1.5,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, viewModel.durationInSeconds);
                },
                child: const Text("Valider"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
