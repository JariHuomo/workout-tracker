import 'package:workouttracker/src/core/domain/entities/exercise.dart';
import 'package:workouttracker/src/core/domain/entities/template.dart';

class GenerateLevelsFromTemplate {
  const GenerateLevelsFromTemplate();

  List<Level> call({
    required ProgressionTemplate template,
    int restSeconds = 90,
  }) {
    final sortedWeeks = [...template.weeks]..sort(
        (a, b) => a.week.compareTo(b.week),
      );
    return sortedWeeks
        .map(
          (week) => Level(
            index: week.week,
            repsPerSet: List<int>.filled(week.sets, week.reps),
            restSeconds: restSeconds,
            isDeload: week.isDeload,
          ),
        )
        .toList();
  }
}

