// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';

// 📦 Package imports:
import 'package:equatable/equatable.dart';

typedef OnFailure = void Function(Failure);

@immutable
sealed class Failure extends Equatable {
  T maybeMap<T extends Object?>({
    T Function(Failure)? onServerFailure,
    T Function(Failure)? onNoElementFailure,
    T Function(Failure)? onInputConverterFailure,
    required T Function() orElse,
  });
}

class ServerFailure extends Failure {
  ServerFailure({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final int statusCode;

  @override
  List<Object?> get props => [message, statusCode];

  @override
  T maybeMap<T extends Object?>({
    T Function(Failure)? onServerFailure,
    T Function(Failure)? onNoElementFailure,
    T Function(Failure)? onInputConverterFailure,
    required T Function() orElse,
  }) {
    return onServerFailure?.call(this) ?? orElse();
  }
}

class NoElementFailure extends Failure {
  @override
  List<Object?> get props => [];

  @override
  T maybeMap<T extends Object?>({
    T Function(Failure)? onServerFailure,
    T Function(Failure)? onNoElementFailure,
    T Function(Failure)? onInputConverterFailure,
    required T Function() orElse,
  }) {
    return onNoElementFailure?.call(this) ?? orElse();
  }
}

class InputConverterFailure extends Failure {
  InputConverterFailure(this.failedValue);

  final String failedValue;

  @override
  List<Object?> get props => [failedValue];

  @override
  T maybeMap<T extends Object?>({
    T Function(Failure)? onServerFailure,
    T Function(Failure)? onNoElementFailure,
    T Function(Failure)? onInputConverterFailure,
    required T Function() orElse,
  }) {
    return onInputConverterFailure?.call(this) ?? orElse();
  }
}
