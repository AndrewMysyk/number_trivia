part of 'number_trivia_bloc.dart';

@immutable
final class NumberTriviaState extends Equatable {
  const NumberTriviaState({
    this.numberTriviaOption = const None(),
    this.isLoading = false,
  });

  final Option<NumberTrivia> numberTriviaOption;
  final bool isLoading;

  NumberTriviaState copyWith({
    Option<NumberTrivia>? numberTriviaOption,
    bool? isLoading,
  }) {
    return NumberTriviaState(
      numberTriviaOption: numberTriviaOption ?? this.numberTriviaOption,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props {
    return [
      numberTriviaOption,
      isLoading,
    ];
  }
}
