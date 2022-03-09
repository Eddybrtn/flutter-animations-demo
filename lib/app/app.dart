import 'package:flutter/material.dart';
import 'package:introducing_animations/ui/screens/home.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animations Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}