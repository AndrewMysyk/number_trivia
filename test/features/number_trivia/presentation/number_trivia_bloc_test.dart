// 📦 Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// 🌎 Project imports:
import 'package:number_trivia/core/error/failures.dart';
import 'package:number_trivia/core/presentation/util/input_coverter.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'number_trivia_bloc_test.mocks.dart';

@GenerateMocks([
  GetConcreteNumberTrivia,
  GetRandomNumberTrivia,
  InputConverter,
])
void main() {
  late NumberTriviaBloc bloc;
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();
    bloc = NumberTriviaBloc(
      mockGetConcreteNumberTrivia,
      mockGetRandomNumberTrivia,
      mockInputConverter,
    );
  });

  test('initial state should be empty', () {
    expect(bloc.state, const NumberTriviaState());
  });

  group('GetTriviaForConcreteNumber', () {
    const tNumberString = '1';
    const tNumberParsed = 1;
    const tNumberTrivia = NumberTrivia(text: 'test', number: tNumberParsed);

    test(
      'should call the InputConverter to validate and convert the string to the unsigned integer',
      () async {
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenAnswer((_) => const Right(tNumberParsed));
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => const Right(tNumberTrivia));
        bloc.add(GetTriviaForConcreteNumber(tNumberString, (f) {}));
        await untilCalled(mockInputConverter.stringToUnsignedInteger(any));
        verify(mockInputConverter.stringToUnsignedInteger(any));
      },
    );
    test(
      'should not change a state after inpute converting failed',
      () async {
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenAnswer((_) => Left(InputConverterFailure(tNumberString)));
        bloc.add(GetTriviaForConcreteNumber(tNumberString, (f) {}));
        await untilCalled(mockInputConverter.stringToUnsignedInteger(any));
        expect(bloc.state, const NumberTriviaState());
        verifyZeroInteractions(mockGetConcreteNumberTrivia);
      },
    );
    test(
      'should execute GetConcreteNumberTrivia usecase after InputConverter returned a valid result',
      () async {
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenAnswer((_) => const Right(tNumberParsed));
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => const Right(tNumberTrivia));
        bloc.add(GetTriviaForConcreteNumber(tNumberString, (f) {}));
        await untilCalled(mockGetConcreteNumberTrivia(any));
        verify(mockGetConcreteNumberTrivia(any));
        verifyZeroInteractions(mockGetRandomNumberTrivia);
      },
    );
    test(
      'should execute GetConcreteNumberTrivia usecase with a valid result returned',
      () async {
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenAnswer((_) => const Right(tNumberParsed));
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => const Right(tNumberTrivia));
        bloc.add(GetTriviaForConcreteNumber(tNumberString, (f) {}));
        final expected = [
          const NumberTriviaState().copyWith(isLoading: true),
          const NumberTriviaState(),
          const NumberTriviaState()
              .copyWith(numberTriviaOption: some(tNumberTrivia)),
        ];
        expectLater(bloc.stream, emitsInOrder(expected));
        verifyZeroInteractions(mockGetRandomNumberTrivia);
      },
    );
    test(
      'should execute GetConcreteNumberTrivia usecase with a failure result returned and not change a state ',
      () async {
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenAnswer((_) => const Right(tNumberParsed));
        when(mockGetConcreteNumberTrivia(any)).thenAnswer(
          (_) async => Left(ServerFailure(message: '', statusCode: 500)),
        );
        bloc.add(GetTriviaForConcreteNumber(tNumberString, (f) {}));
        final expected = [
          const NumberTriviaState().copyWith(isLoading: true),
          const NumberTriviaState(),
        ];
        expectLater(bloc.stream, emitsInOrder(expected));
        verifyZeroInteractions(mockGetRandomNumberTrivia);
      },
    );
  });

  group('GetRandomTrivia', () {
    const tNumberTrivia = NumberTrivia(text: 'test', number: 1);

    test(
      'should execute GetRandomNumberTrivia usecase',
      () async {
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => const Right(tNumberTrivia));
        bloc.add(GetRandomTrivia((f) {}));
        await untilCalled(mockGetRandomNumberTrivia(any));
        verify(mockGetRandomNumberTrivia(any));
        verifyZeroInteractions(mockGetConcreteNumberTrivia);
      },
    );
    test(
      'should execute a GetRandomNumberTrivia usecase with a valid result returned',
      () async {
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => const Right(tNumberTrivia));
        bloc.add(GetRandomTrivia((f) {}));
        final expected = [
          const NumberTriviaState().copyWith(isLoading: true),
          const NumberTriviaState(),
          const NumberTriviaState()
              .copyWith(numberTriviaOption: some(tNumberTrivia)),
        ];
        expectLater(bloc.stream, emitsInOrder(expected));
        verifyZeroInteractions(mockGetConcreteNumberTrivia);
      },
    );
    test(
      'should execute a GetRandomNumberTrivia usecase with a failure result returned and not change a state ',
      () async {
        when(mockGetRandomNumberTrivia(any)).thenAnswer(
          (_) async => Left(ServerFailure(message: '', statusCode: 500)),
        );
        bloc.add(GetRandomTrivia((f) {}));
        final expected = [
          const NumberTriviaState().copyWith(isLoading: true),
          const NumberTriviaState(),
        ];
        expectLater(bloc.stream, emitsInOrder(expected));
      },
    );
  });
}
