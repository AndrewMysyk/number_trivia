// 🌎 Project imports:
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  /// Calls the http://numbersapi.com/#42
  ///
  /// Throws a [ServerFailure] for all error codes
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  /// Calls the http://numbersapi.com/#random/trivia
  ///
  /// Throws a [ServerFailure] for all error codes
  Future<NumberTriviaModel> getRandomNumberTrivia();
}
