import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  const Detail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Détail")),
      body: const Center(
        child: Hero(
          tag: "flutter-logo",
          child: FlutterLogo(
            size: 150,
            style: FlutterLogoStyle.stacked,
          ),
        ),
      ),
    );
  }
}
