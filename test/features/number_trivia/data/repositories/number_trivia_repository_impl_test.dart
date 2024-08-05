// 📦 Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// 🌎 Project imports:
import 'package:number_trivia/core/error/failures.dart';
import 'package:number_trivia/core/platform/connectivity_observer.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'number_trivia_repository_impl_test.mocks.dart';

@GenerateMocks([
  NumberTriviaLocalDataSource,
  NumberTriviaRemoteDataSource,
  ConnectivityObserver,
])
void main() {
  late NumberTriviaRepositoryImpl repository;
  late MockNumberTriviaLocalDataSource mockNumberTriviaLocalDataSource;
  late MockNumberTriviaRemoteDataSource mockNumberTriviaRemoteDataSource;
  late MockConnectivityObserver mockConnectivityObserver;

  setUp(() {
    mockNumberTriviaLocalDataSource = MockNumberTriviaLocalDataSource();
    mockNumberTriviaRemoteDataSource = MockNumberTriviaRemoteDataSource();
    mockConnectivityObserver = MockConnectivityObserver();
    repository = NumberTriviaRepositoryImpl(
      numberTriviaRemoteDataSource: mockNumberTriviaRemoteDataSource,
      numberTriviaLocalDataSource: mockNumberTriviaLocalDataSource,
      connectivityObserver: mockConnectivityObserver,
    );
  });

  group('getConcreteNumberTrivia', () {
    const testNumber = 1;
    const tNumberTriviaModel = NumberTriviaModel(
      text: 'test',
      number: testNumber,
    );

    setUp(() {
      when(
        mockNumberTriviaLocalDataSource.saveNumberTrivia(tNumberTriviaModel),
      ).thenAnswer((_) async => true);
      when(mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(any))
          .thenAnswer((_) async => tNumberTriviaModel);
    });

    test('should check if the device is online', () {
      when(mockConnectivityObserver.isNetworkAvailable)
          .thenAnswer((_) async => true);
      repository.getConcreteNumberTrivia(testNumber);
      verify(mockConnectivityObserver.isNetworkAvailable);
    });

    group('device is online', () {
      setUp(() {
        when(mockConnectivityObserver.isNetworkAvailable)
            .thenAnswer((_) async => true);
      });

      test(
        'shoud return remote data when the call to remote data source is successful',
        () async {
          await repository.getConcreteNumberTrivia(testNumber);
          verify(
            mockNumberTriviaRemoteDataSource
                .getConcreteNumberTrivia(testNumber),
          );
        },
      );

      test(
        'shoud cache the data locally when the call to remote data source is successful',
        () async {
          await repository.getConcreteNumberTrivia(testNumber);
          verify(
            mockNumberTriviaRemoteDataSource
                .getConcreteNumberTrivia(testNumber),
          );
          verify(
            mockNumberTriviaLocalDataSource
                .saveNumberTrivia(tNumberTriviaModel),
          );
        },
      );
    });

    group('device is offline', () {
      setUp(() {
        when(mockConnectivityObserver.isNetworkAvailable)
            .thenAnswer((_) async => false);
      });

      test(
        'should return locally cached data when the cached data is present',
        () async {
          when(
            mockNumberTriviaLocalDataSource.getConcreteNumberTrivia(testNumber),
          ).thenAnswer((_) async => tNumberTriviaModel);
          final result = await repository.getConcreteNumberTrivia(testNumber);
          verifyZeroInteractions(mockNumberTriviaRemoteDataSource);
          verify(
            mockNumberTriviaLocalDataSource.getConcreteNumberTrivia(testNumber),
          );
          expect(result, const Right(tNumberTriviaModel));
        },
      );

      test('should return a failure if cache does not contain any data',
          () async {
        when(
          mockNumberTriviaLocalDataSource.getConcreteNumberTrivia(testNumber),
        ).thenAnswer((_) async => throw NoElementFailure());
        final result = await repository.getConcreteNumberTrivia(testNumber);
        verifyZeroInteractions(mockNumberTriviaRemoteDataSource);
        verify(
          mockNumberTriviaLocalDataSource.getConcreteNumberTrivia(testNumber),
        );
        expect(result, Left(NoElementFailure()));
      });
    });
  });

  group('getRandomNumberTrivia', () {
    const tNumberTriviaModel = NumberTriviaModel(
      text: 'test',
      number: 123,
    );

    setUp(() {
      when(
        mockNumberTriviaLocalDataSource.saveNumberTrivia(tNumberTriviaModel),
      ).thenAnswer((_) async => true);
      when(mockNumberTriviaRemoteDataSource.getRandomNumberTrivia())
          .thenAnswer((_) async => tNumberTriviaModel);
    });

    test('should check if the device is online', () {
      when(mockConnectivityObserver.isNetworkAvailable)
          .thenAnswer((_) async => true);
      repository.getRandomNumberTrivia();
      verify(mockConnectivityObserver.isNetworkAvailable);
    });

    group('device is online', () {
      setUp(() {
        when(mockConnectivityObserver.isNetworkAvailable)
            .thenAnswer((_) async => true);
      });

      test(
        'shoud return remote data when the call to remote data source is successful',
        () async {
          await repository.getRandomNumberTrivia();
          verify(
            mockNumberTriviaRemoteDataSource.getRandomNumberTrivia(),
          );
        },
      );

      test(
        'shoud cache the data locally when the call to remote data source is successful',
        () async {
          await repository.getRandomNumberTrivia();
          verify(
            mockNumberTriviaRemoteDataSource.getRandomNumberTrivia(),
          );
          verify(
            mockNumberTriviaLocalDataSource
                .saveNumberTrivia(tNumberTriviaModel),
          );
        },
      );
    });

    group('device is offline', () {
      setUp(() {
        when(mockConnectivityObserver.isNetworkAvailable)
            .thenAnswer((_) async => false);
      });

      test(
        'should return locally cached data when the cached data is present',
        () async {
          when(
            mockNumberTriviaLocalDataSource.getRandomNumberTrivia(),
          ).thenAnswer((_) async => tNumberTriviaModel);
          final result = await repository.getRandomNumberTrivia();
          verifyZeroInteractions(mockNumberTriviaRemoteDataSource);
          verify(
            mockNumberTriviaLocalDataSource.getRandomNumberTrivia(),
          );
          expect(result, const Right(tNumberTriviaModel));
        },
      );

      test('should return a failure if cache does not contain any data',
          () async {
        when(
          mockNumberTriviaLocalDataSource.getRandomNumberTrivia(),
        ).thenAnswer((_) async => throw NoElementFailure());
        final result = await repository.getRandomNumberTrivia();
        verifyZeroInteractions(mockNumberTriviaRemoteDataSource);
        verify(
          mockNumberTriviaLocalDataSource.getRandomNumberTrivia(),
        );
        expect(result, Left(NoElementFailure()));
      });
    });
  });
}
