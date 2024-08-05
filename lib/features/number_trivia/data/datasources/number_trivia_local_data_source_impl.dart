// 📦 Package imports:
import 'package:injectable/injectable.dart';

// 🌎 Project imports:
import 'package:number_trivia/core/database/dao/number_trivia_dao.dart';
import 'package:number_trivia/core/database/dao/number_trivia_data_converter.dart';
import 'package:number_trivia/core/error/failures.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

@LazySingleton(as: NumberTriviaLocalDataSource)
class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  NumberTriviaLocalDataSourceImpl(NumberTriviaDao numberTriviaDao)
      : _numberTriviaDao = numberTriviaDao;

  final NumberTriviaDao _numberTriviaDao;

  @override
  Future<NumberTrivia> getConcreteNumberTrivia(int number) async {
    final result = await _numberTriviaDao
        .getConcreteNumberTrivia(number)
        .onError((_, __) => throw NoElementFailure);
    return result.toEntity();
  }

  @override
  Future<NumberTrivia> getRandomNumberTrivia() async {
    final result = await _numberTriviaDao
        .getRandomNumberTrivia()
        .onError((_, __) => throw NoElementFailure);
    return result.toEntity();
  }

  @override
  Future<void> saveNumberTrivia(NumberTrivia numberTrivia) {
    return _numberTriviaDao
        .saveNumberTrivia(NumberTriviaDataConverter.fromEntity(numberTrivia));
  }
}
