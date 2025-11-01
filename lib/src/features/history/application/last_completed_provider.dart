import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttracker/src/core/application/providers.dart';

/// Map of exerciseId -> most recent session end time (null if never ended)
final lastCompletedByExerciseProvider =
    FutureProvider.autoDispose<Map<String, DateTime?>>((ref) async {
  final result = await ref.read(getSessionsUseCaseProvider)();
  return result.match(
    (_) => <String, DateTime?>{},
    (sessions) {
      final map = <String, DateTime?>{};
      for (final s in sessions) {
        final ended = s.endedAt;
        if (ended == null) continue;
        final prev = map[s.exerciseId];
        if (prev == null || ended.isAfter(prev)) {
          map[s.exerciseId] = ended;
        }
      }
      return map;
    },
  );
});
