// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:number_trivia/app.dart';
import 'package:number_trivia/injection.dart';

void main() async {
  await configureDependencies();
  runApp(const App());
}
