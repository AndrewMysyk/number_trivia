// 🎯 Dart imports:
import 'dart:convert';

// 📦 Package imports:
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

// 🌎 Project imports:
import 'package:number_trivia/core/error/failures.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';

@LazySingleton(as: NumberTriviaRemoteDataSource)
class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  NumberTriviaRemoteDataSourceImpl(this._client);

  final http.Client _client;

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) {
    return _executeRequest('http://numbersapi.com/$number');
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() {
    return _executeRequest('http://numbersapi.com/random');
  }

  Future<NumberTriviaModel> _executeRequest(String url) async {
    final response = await _client.get(
      Uri.parse(url),
      headers: {'content-type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(
        json.decode(response.body) as Map<String, dynamic>,
      );
    }
    throw ServerFailure(
      message: response.body,
      statusCode: response.statusCode,
    );
  }
}
