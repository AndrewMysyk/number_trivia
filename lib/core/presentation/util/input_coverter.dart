// 📦 Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// 🌎 Project imports:
import 'package:number_trivia/core/error/failures.dart';

@LazySingleton()
class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String value) {
    try {
      final integer = int.parse(value);
      if (integer.isNegative) throw const FormatException();
      return Right(integer);
    } on FormatException {
      return Left(InputConverterFailure(value));
    }
  }
}
