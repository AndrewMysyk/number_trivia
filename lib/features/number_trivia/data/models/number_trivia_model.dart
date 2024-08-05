// 📦 Package imports:
import 'package:json_annotation/json_annotation.dart';

// 🌎 Project imports:
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

part 'number_trivia_model.g.dart';

@JsonSerializable()
class NumberTriviaModel extends NumberTrivia {
  const NumberTriviaModel({
    required super.text,
    required super.number,
  });

  static NumberTriviaModel fromJson(Map<String, dynamic> json) {
    return _$NumberTriviaModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$NumberTriviaModelToJson(this);
  }
}
