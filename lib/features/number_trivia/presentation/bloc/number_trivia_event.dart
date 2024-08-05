part of 'number_trivia_bloc.dart';

@immutable
sealed class NumberTriviaEvent extends Equatable {}

class GetTriviaForConcreteNumber extends NumberTriviaEvent {
  GetTriviaForConcreteNumber(this.numberString, this.onFailure);

  final String numberString;
  final OnFailure onFailure;

  @override
  List<Object?> get props => [numberString, onFailure];
}

class GetRandomTrivia extends NumberTriviaEvent {
  GetRandomTrivia(this.onFailure);

  final OnFailure onFailure;

  @override
  List<Object?> get props => [onFailure];
}
