// 📦 Package imports:
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

// 🌎 Project imports:
import 'package:number_trivia/core/error/failures.dart';
import 'package:number_trivia/core/usecases/usecase.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';

@LazySingleton()
class GetConcreteNumberTrivia implements UseCase<NumberTrivia, Params> {
  GetConcreteNumberTrivia(this.repository);

  final NumberTriviaRepository repository;

  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) {
    return repository.getConcreteNumberTrivia(params.number);
  }
}

class Params extends Equatable {
  const Params({required this.number});

  final int number;

  @override
  List<Object?> get props => [number];
}
