import 'dart:math';

import 'package:workouttracker/src/core/domain/entities/exercise.dart';

/// Modes for manual level generation.
enum ManualGenerationMode { uniform, ladder }

/// Generates levels for manual configuration with two strategies:
/// - Uniform mode: each level uses identical reps per set for all sets and
///   increases by the configured step value.
/// - Ladder mode: progresses gradually by upgrading one set at a time toward
///   the next target reps, producing micro-steps between uniform rows for a
///   slower progression.
class GenerateLevelsManual {
  const GenerateLevelsManual();

  List<Level> call({
    required int sets,
    required int startReps,
    required int endReps,
    required int step,
    required int restSeconds,
    ManualGenerationMode mode = ManualGenerationMode.uniform,
    int? deloadEvery,
    double? deloadPct,
  }) {
    // Sanitize inputs
    final totalSets = max(1, sets);
    final first = max(1, startReps);
    final last = max(first, endReps);
    final inc = max(1, step);
    final deloadFrequency = (deloadEvery ?? 0) > 0 ? deloadEvery! : 0;
    final deloadPercent =
        (deloadPct != null && deloadPct > 0 && deloadPct < 1) ? deloadPct : 0.0;

    final levels = <Level>[];
    var index = 1;
    var workSinceDeload = 0; // counts only non-deload levels

    void maybeInsertDeload(List<int> baseRow) {
      if (deloadFrequency <= 0 || deloadPercent <= 0) return;
      if (workSinceDeload % deloadFrequency != 0) return;
      // Compute reduced reps per set based on the most recent work level.
      final reduced = baseRow
          .map((r) => max(1, (r * (1 - deloadPercent)).floor()))
          .toList(growable: false);
      levels.add(
        Level(
          index: index++,
          repsPerSet: reduced,
          restSeconds: restSeconds,
          isDeload: true,
        ),
      );
    }

    if (mode == ManualGenerationMode.uniform) {
      for (var reps = first; reps <= last; reps += inc) {
        final row = List<int>.filled(totalSets, reps);
        levels.add(
          Level(
            index: index++,
            repsPerSet: row,
            restSeconds: restSeconds,
          ),
        );
        workSinceDeload++;
        maybeInsertDeload(row);
      }
      return levels;
    }

    // Ladder mode
    var currentRow = List<int>.filled(totalSets, first);
    // Always include the initial uniform row
    levels.add(
      Level(
        index: index++,
        repsPerSet: List<int>.from(currentRow),
        restSeconds: restSeconds,
      ),
    );
    workSinceDeload++;
    maybeInsertDeload(currentRow);

    for (var target = first + inc; target <= last; target += inc) {
      // For each new target, produce micro-steps updating one set at a time.
      for (var setIdx = 0; setIdx < totalSets; setIdx++) {
        if (currentRow[setIdx] >= target) continue;
        currentRow = List<int>.from(currentRow);
        currentRow[setIdx] = target;
        levels.add(
          Level(
            index: index++,
            repsPerSet: List<int>.from(currentRow),
            restSeconds: restSeconds,
          ),
        );
        workSinceDeload++;
        maybeInsertDeload(currentRow);
      }
    }

    return levels;
  }
}
