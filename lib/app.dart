// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:number_trivia/features/number_trivia/presentation/pages/number_trivia_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia',
      theme: ThemeData.dark(),
      home: const NumberTriviaPage(),
    );
  }
}
