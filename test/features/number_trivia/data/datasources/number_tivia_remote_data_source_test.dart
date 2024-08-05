// 🎯 Dart imports:
import 'dart:convert';

// 📦 Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// 🌎 Project imports:
import 'package:number_trivia/core/error/failures.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_remote_data_source_impl.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'number_tivia_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late NumberTriviaRemoteDataSourceImpl dataSource;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(mockClient);
  });

  group('getConcreteNumberTrivia', () {
    const tNumber = 1;
    final tNumberTriviaModel = NumberTriviaModel.fromJson(
      json.decode(fixture('trivia.json')) as Map<String, dynamic>,
    );

    group('succes cases', () {
      setUp(() {
        when(
          mockClient.get(any, headers: anyNamed('headers')),
        ).thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
      });

      test(
        '''
should perform a GET request on a URL with number being the endpoint 
      and with application/json header''',
        () async {
          dataSource.getConcreteNumberTrivia(tNumber);
          verify(
            mockClient.get(
              Uri.parse('http://numbersapi.com/$tNumber'),
              headers: {'content-type': 'application/json'},
            ),
          );
        },
      );
      test(
        'should return NumberTrivia when the response code is 200',
        () async {
          final response = await dataSource.getConcreteNumberTrivia(tNumber);
          expect(response, equals(tNumberTriviaModel));
        },
      );
    });

    test(
      'should throw a server exception when the response code is not 200',
      () async {
        when(
          mockClient.get(any, headers: anyNamed('headers')),
        ).thenAnswer((_) async => http.Response('something went wrong', 500));
        final call = dataSource.getConcreteNumberTrivia;
        expect(
          () => call(tNumber),
          throwsA(const TypeMatcher<ServerFailure>()),
        );
      },
    );
  });

  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel = NumberTriviaModel.fromJson(
      json.decode(fixture('trivia.json')) as Map<String, dynamic>,
    );

    group('succes cases', () {
      setUp(() {
        when(
          mockClient.get(any, headers: anyNamed('headers')),
        ).thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
      });

      test(
        '''
should perform a GET request on a URL with number being the endpoint 
      and with application/json header''',
        () async {
          dataSource.getRandomNumberTrivia();
          verify(
            mockClient.get(
              Uri.parse('http://numbersapi.com/random'),
              headers: {'content-type': 'application/json'},
            ),
          );
        },
      );
      test(
        'should return NumberTrivia when the response code is 200',
        () async {
          final response = await dataSource.getRandomNumberTrivia();
          expect(response, equals(tNumberTriviaModel));
        },
      );
    });

    test(
      'should throw a server exception when the response code is not 200',
      () async {
        when(
          mockClient.get(any, headers: anyNamed('headers')),
        ).thenAnswer((_) async => http.Response('something went wrong', 500));
        final call = dataSource.getRandomNumberTrivia;
        expect(
          () => call(),
          throwsA(const TypeMatcher<ServerFailure>()),
        );
      },
    );
  });
}
