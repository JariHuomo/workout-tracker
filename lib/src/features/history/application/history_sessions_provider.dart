import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttracker/src/core/application/providers.dart';
import 'package:workouttracker/src/core/domain/entities/session.dart';

final historySessionsProvider =
    FutureProvider.autoDispose<List<WorkoutSession>>((ref) async {
  final getSessions = ref.read(getSessionsUseCaseProvider);
  final result = await getSessions();
  return result.match(
    (failure) => throw failure,
    (sessions) => sessions,
  );
});
