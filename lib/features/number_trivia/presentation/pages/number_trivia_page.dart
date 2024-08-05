// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:number_trivia/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:number_trivia/features/number_trivia/presentation/widgets/number_trivia_container.dart';
import 'package:number_trivia/injection.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<NumberTriviaBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Number Trivia'),
        ),
        body: const NumberTriviaContainer(),
      ),
    );
  }
}
