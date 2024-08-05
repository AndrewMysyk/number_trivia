// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia',
      theme: ThemeData.dark(),
      home: const SizedBox.shrink(),
    );
  }
}
