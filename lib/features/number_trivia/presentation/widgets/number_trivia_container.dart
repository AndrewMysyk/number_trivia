// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:number_trivia/core/error/failures.dart';
import 'package:number_trivia/core/presentation/widgets/app_snack_bar.dart';
import 'package:number_trivia/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:number_trivia/features/number_trivia/presentation/widgets/number_trivia_widget.dart';

class NumberTriviaContainer extends StatefulWidget {
  const NumberTriviaContainer({super.key});

  @override
  State<NumberTriviaContainer> createState() => _NumberTriviaContainerState();
}

class _NumberTriviaContainerState extends State<NumberTriviaContainer> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleFailure(Failure f) {
    showAppSnackBar(
      context,
      message: f.maybeMap(
        onServerFailure: (_) => 'Server failure',
        onInputConverterFailure: (_) => 'Failed to convert input',
        orElse: () => 'Something went wrong',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
              builder: (context, state) => state.numberTriviaOption.fold(
                () => const Center(child: Text('Start searching!')),
                (numberTrivia) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Center(
                    child: NumberTriviaWidget(numberTrivia: numberTrivia),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          SearchBar(
            controller: _controller,
            constraints: const BoxConstraints(minHeight: 42.0),
            hintText: 'Input a positive integer',
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            onSubmitted: (v) => context.read<NumberTriviaBloc>().add(
                  GetTriviaForConcreteNumber(v, (f) => _handleFailure(f)),
                ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24.0),
          Row(
            children: [
              TextButton(
                onPressed: () => context.read<NumberTriviaBloc>().add(
                      GetTriviaForConcreteNumber(
                        _controller.text,
                        (f) => _handleFailure(f),
                      ),
                    ),
                child: const Text('Search'),
              ),
              const SizedBox(width: 16.0),
              TextButton(
                onPressed: () => context.read<NumberTriviaBloc>().add(
                      GetRandomTrivia(
                        (f) => _handleFailure(f),
                      ),
                    ),
                child: const Text('Get random'),
              ),
            ],
          ),
          const SizedBox(height: 32.0),
        ],
      ),
    );
  }
}
