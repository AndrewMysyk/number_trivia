// 📦 Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// 🌎 Project imports:
import 'package:number_trivia/core/database/app_database.dart';
import 'package:number_trivia/core/database/dao/number_trivia_dao.dart';
import 'package:number_trivia/core/error/failures.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_local_data_source_impl.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'number_trivia_local_data_source_test.mocks.dart';

@GenerateMocks([NumberTriviaDao])
void main() {
  late NumberTriviaLocalDataSourceImpl dataSource;
  late MockNumberTriviaDao mockNumberTriviaDao;

  setUp(() {
    mockNumberTriviaDao = MockNumberTriviaDao();
    dataSource = NumberTriviaLocalDataSourceImpl(mockNumberTriviaDao);
  });

  const tNumber = 1;
  const tDescription = 'test';
  const tNumberTriviaModel = NumberTrivia(
    text: tDescription,
    number: tNumber,
  );
  const tNumberTriviaTableData = NumberTriviaTableData(
    number: tNumber,
    description: tDescription,
  );

  group('getConcreteNumberTrivia', () {
    test(
      'should return NumberTrivia from sqlite db when there is at least one presented in the db',
      () async {
        when(mockNumberTriviaDao.getConcreteNumberTrivia(tNumber))
            .thenAnswer((_) async => tNumberTriviaTableData);
        final result = await dataSource.getConcreteNumberTrivia(tNumber);
        verify(mockNumberTriviaDao.getConcreteNumberTrivia(tNumber));
        expect(result, tNumberTriviaModel);
      },
    );
    test(
      'should throw NoElementFailure if there is no presented NumberTrivia in the db',
      () async {
        when(mockNumberTriviaDao.getConcreteNumberTrivia(tNumber))
            .thenAnswer((_) async => throw StateError);
        expect(
          () => dataSource.getConcreteNumberTrivia(tNumber),
          throwsA(NoElementFailure),
        );
        verify(mockNumberTriviaDao.getConcreteNumberTrivia(tNumber));
      },
    );
  });

  group('getRandomNumberTrivia', () {
    test(
      'should return a random Number Trivia from sqlite db when there is at least one presented in the db',
      () async {
        when(mockNumberTriviaDao.getRandomNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaTableData);
        final result = await dataSource.getRandomNumberTrivia();
        verify(mockNumberTriviaDao.getRandomNumberTrivia());
        expect(result, tNumberTriviaModel);
      },
    );
    test(
      'should throw NoElementFailure if there is no presented NumberTrivia in the db',
      () async {
        when(mockNumberTriviaDao.getRandomNumberTrivia())
            .thenAnswer((_) async => throw StateError);
        expect(
          () => dataSource.getRandomNumberTrivia(),
          throwsA(NoElementFailure),
        );
        verify(mockNumberTriviaDao.getRandomNumberTrivia());
      },
    );
  });

  group('saveNumberTrivia', () {
    test(
      'should execute a db query to store a given Number Trivia',
      () async {
        when(mockNumberTriviaDao.saveNumberTrivia(tNumberTriviaTableData))
            .thenAnswer((_) async => tNumber);
        await dataSource.saveNumberTrivia(tNumberTriviaModel);
        verify(mockNumberTriviaDao.saveNumberTrivia(tNumberTriviaTableData));
      },
    );
  });
}
