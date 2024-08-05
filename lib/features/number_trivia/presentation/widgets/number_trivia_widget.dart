// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

class NumberTriviaWidget extends StatelessWidget {
  const NumberTriviaWidget({
    required this.numberTrivia,
    super.key,
  });

  final NumberTrivia numberTrivia;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          numberTrivia.number.toString(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12.0),
        Text(
          numberTrivia.text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
