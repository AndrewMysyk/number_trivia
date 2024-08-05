// 🌎 Project imports:
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaLocalDataSource {
  /// Calls the database for the concrete number trivia
  /// Return null in case of no match
  ///
  /// Throws a [NoElementFailure] for all error codes
  Future<NumberTrivia> getConcreteNumberTrivia(int number);

  /// Calls the database for the random number trivia
  /// Return null in case of there no records on database
  ///
  /// Throws a [NoElementFailure] for all error codes
  Future<NumberTrivia> getRandomNumberTrivia();

  /// Calls the database for the save a given number trivia
  Future<void> saveNumberTrivia(NumberTrivia numberTrivia);
}
