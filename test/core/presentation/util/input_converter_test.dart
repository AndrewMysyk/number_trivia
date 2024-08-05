// 📦 Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

// 🌎 Project imports:
import 'package:number_trivia/core/error/failures.dart';
import 'package:number_trivia/core/presentation/util/input_coverter.dart';

void main() {
  late InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('stringToUnsignedInteger', () {
    test(
      'should return an integer when the string represents an unsigned integer',
      () async {
        const str = '1337';
        final result = inputConverter.stringToUnsignedInteger(str);
        expect(result, const Right(1337));
      },
    );
    test(
      'should return a failure when the string is not an integer',
      () async {
        const str = '3.14';
        final result = inputConverter.stringToUnsignedInteger(str);
        expect(result, Left(InputConverterFailure(str)));
      },
    );
    test(
      'should return a failure when the string is a negative integer',
      () async {
        const str = '-1337';
        final result = inputConverter.stringToUnsignedInteger(str);
        expect(result, Left(InputConverterFailure(str)));
      },
    );
  });
}
