import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.general(String message) = _GeneralFailure;
  const factory Failure.storage(String message) = _StorageFailure;
}

extension FailureX on Failure {
  String get message => when(
        general: (message) => message,
        storage: (message) => message,
      );
}
