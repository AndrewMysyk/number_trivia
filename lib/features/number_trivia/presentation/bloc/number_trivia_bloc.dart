// 🎯 Dart imports:
import 'dart:async';

// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';

// 📦 Package imports:
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

// 🌎 Project imports:
import 'package:number_trivia/core/error/failures.dart';
import 'package:number_trivia/core/presentation/util/input_coverter.dart';
import 'package:number_trivia/core/usecases/usecase.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

@injectable
class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  NumberTriviaBloc(
    this._getConcreteNumberTrivia,
    this._getRandomNumberTrivia,
    this._inputConverter,
  ) : super(const NumberTriviaState()) {
    on<GetTriviaForConcreteNumber>((event, emit) async {
      await _getTriviaForConcreteNumber(event, emit);
    });
    on<GetRandomTrivia>((event, emit) async {
      await _getRandomTrivia(event, emit);
    });
  }
  final GetConcreteNumberTrivia _getConcreteNumberTrivia;
  final GetRandomNumberTrivia _getRandomNumberTrivia;
  final InputConverter _inputConverter;

  Future<void> _getTriviaForConcreteNumber(
    GetTriviaForConcreteNumber event,
    Emitter<NumberTriviaState> emit,
  ) async {
    final convertResultOption =
        _inputConverter.stringToUnsignedInteger(event.numberString);
    await convertResultOption.fold<FutureOr>(
      event.onFailure,
      (convertResult) async {
        emit(state.copyWith(isLoading: true));
        final failureOrNumberTrivia = await _getConcreteNumberTrivia(
          Params(number: convertResult),
        );
        emit(state.copyWith(isLoading: false));
        return failureOrNumberTrivia.fold(
          event.onFailure,
          (numberTrivia) =>
              emit(state.copyWith(numberTriviaOption: some(numberTrivia))),
        );
      },
    );
  }

  Future<void> _getRandomTrivia(
    GetRandomTrivia event,
    Emitter<NumberTriviaState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final failureOrNumberTrivia = await _getRandomNumberTrivia(NoParams());
    emit(state.copyWith(isLoading: false));
    return failureOrNumberTrivia.fold(
      event.onFailure,
      (numberTrivia) =>
          emit(state.copyWith(numberTriviaOption: some(numberTrivia))),
    );
  }
}
