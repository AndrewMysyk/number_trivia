// 🌎 Project imports:
import 'package:number_trivia/core/database/app_database.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

extension NumberTriviaDataConverter on NumberTriviaTableData {
  static NumberTriviaTableData fromEntity(NumberTrivia numberTrivia) {
    return NumberTriviaTableData(
      number: numberTrivia.number,
      description: numberTrivia.text,
    );
  }

  NumberTrivia toEntity() {
    return NumberTrivia(
      text: description,
      number: number,
    );
  }
}
