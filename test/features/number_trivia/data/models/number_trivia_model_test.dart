// 🎯 Dart imports:
import 'dart:convert';

// 📦 Package imports:
import 'package:flutter_test/flutter_test.dart';

// 🌎 Project imports:
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  const testNumberTriviaModel = NumberTriviaModel(number: 1, text: 'test');

  test('shoud be a subclass of NumberTrivia entity', () {
    expect(testNumberTriviaModel, isA<NumberTrivia>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON number is an integer',
        () async {
      final jsonMap =
          json.decode(fixture('trivia.json')) as Map<String, dynamic>;
      final result = NumberTriviaModel.fromJson(jsonMap);
      expect(result, testNumberTriviaModel);
    });
    test(
        'should return a valid model when the JSON number is regarded as a double',
        () async {
      final jsonMap =
          json.decode(fixture('trivia_double.json')) as Map<String, dynamic>;
      final result = NumberTriviaModel.fromJson(jsonMap);
      expect(result, testNumberTriviaModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      final result = testNumberTriviaModel.toJson();
      final expectedMap = {
        "text": "test",
        "number": 1,
      };
      expect(result, expectedMap);
    });
  });
}
