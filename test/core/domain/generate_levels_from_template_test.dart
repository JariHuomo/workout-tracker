import 'package:test/test.dart';
import 'package:workouttracker/src/core/domain/entities/template.dart';
import 'package:workouttracker/src/core/domain/usecases/generate_levels_from_template.dart';

void main() {
  const generateLevels = GenerateLevelsFromTemplate();

  ProgressionTemplate buildTemplate() {
    return ProgressionTemplate(
      id: 'test',
      name: 'Test Template',
      description: 'Checks generation order',
      targetAudience: 'Any',
      estimatedWeeks: 2,
      deloadFrequency: 4,
      deloadPercentage: 0.25,
      difficulty: 'easy',
      weeks: const [
        WeekProtocol(week: 2, sets: 5, reps: 3),
        WeekProtocol(week: 1, sets: 4, reps: 2, isDeload: true),
      ],
    );
  }

  test('GenerateLevelsFromTemplate sorts by week and maps values', () {
    final template = buildTemplate();

    final levels = generateLevels(template: template, restSeconds: 120);

    expect(levels, hasLength(2));
    expect(levels.first.index, 1);
    expect(levels.first.repsPerSet, equals(List<int>.filled(4, 2)));
    expect(levels.first.isDeload, isTrue);
    expect(levels.first.restSeconds, 120);
    expect(levels.last.index, 2);
    expect(levels.last.isDeload, isFalse);
  });

  test('GenerateLevelsFromTemplate applies default rest', () {
    final template = buildTemplate();

    final levels = generateLevels(template: template);

    for (final level in levels) {
      expect(level.restSeconds, 90);
    }
  });
}
