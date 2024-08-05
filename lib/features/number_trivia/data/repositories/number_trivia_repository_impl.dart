// 📦 Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// 🌎 Project imports:
import 'package:number_trivia/core/error/failures.dart';
import 'package:number_trivia/core/platform/connectivity_observer.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';

@LazySingleton(as: NumberTriviaRepository)
class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  NumberTriviaRepositoryImpl({
    required NumberTriviaRemoteDataSource numberTriviaRemoteDataSource,
    required NumberTriviaLocalDataSource numberTriviaLocalDataSource,
    required ConnectivityObserver connectivityObserver,
  })  : _numberTriviaRemoteDataSource = numberTriviaRemoteDataSource,
        _numberTriviaLocalDataSource = numberTriviaLocalDataSource,
        _connectivityObserver = connectivityObserver;

  final NumberTriviaRemoteDataSource _numberTriviaRemoteDataSource;
  final NumberTriviaLocalDataSource _numberTriviaLocalDataSource;
  final ConnectivityObserver _connectivityObserver;

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
    int number,
  ) {
    return _getNumberTrivia(
      () => _numberTriviaRemoteDataSource.getConcreteNumberTrivia(number),
      () => _numberTriviaLocalDataSource.getConcreteNumberTrivia(number),
    );
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() {
    return _getNumberTrivia(
      () => _numberTriviaRemoteDataSource.getRandomNumberTrivia(),
      () => _numberTriviaLocalDataSource.getRandomNumberTrivia(),
    );
  }

  Future<Either<Failure, NumberTrivia>> _getNumberTrivia(
    Future<NumberTrivia> Function() remoteExecutor,
    Future<NumberTrivia> Function() localExecutor,
  ) async {
    if (await _connectivityObserver.isNetworkAvailable) {
      try {
        final trivia = await remoteExecutor();
        _numberTriviaLocalDataSource.saveNumberTrivia(trivia);
        return Right(trivia);
      } on ServerFailure catch (e) {
        return Left(e);
      }
    }
    try {
      final localTrivia = await localExecutor();
      return Right(localTrivia);
    } on NoElementFailure catch (f) {
      return Left(f);
    }
  }
}
