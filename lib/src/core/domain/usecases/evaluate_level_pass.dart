import 'package:workouttracker/src/core/domain/entities/session.dart';

class EvaluateLevelPass {
  bool call({
    required List<int> targetRepsPerSet,
    required List<SetAttempt> attempts,
  }) {
    final bySet = <int, int>{};
    for (final a in attempts) {
      bySet[a.setIndex] = a.reps; // last write wins
    }
    for (var i = 0; i < targetRepsPerSet.length; i++) {
      final target = targetRepsPerSet[i];
      final reps = bySet[i] ?? 0;
      if (reps < target) return false;
    }
    return true;
  }
}
