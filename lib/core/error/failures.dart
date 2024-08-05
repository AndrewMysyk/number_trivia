// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';

// 📦 Package imports:
import 'package:equatable/equatable.dart';

@immutable
sealed class Failure extends Equatable {}

class ServerFailure extends Failure {
  ServerFailure({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final int statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class NoElementFailure extends Failure {
  @override
  List<Object?> get props => [];
}
