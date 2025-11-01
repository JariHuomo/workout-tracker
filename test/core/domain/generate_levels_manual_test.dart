import 'package:test/test.dart';
import 'package:workouttracker/src/core/domain/usecases/generate_levels_manual.dart';

void main() {
  group('GenerateLevelsManual - uniform', () {
    test('generates uniform rows from start..end with step 1', () {
      const usecase = GenerateLevelsManual();
      final levels = usecase(
        sets: 5,
        startReps: 1,
        endReps: 3,
        step: 1,
        restSeconds: 90,
      );
      expect(levels.length, 3);
      expect(levels[0].repsPerSet, List<int>.filled(5, 1));
      expect(levels[1].repsPerSet, List<int>.filled(5, 2));
      expect(levels[2].repsPerSet, List<int>.filled(5, 3));
      expect(levels.every((l) => l.isDeload == false), isTrue);
    });

    test('inserts deloads after N work levels', () {
      const usecase = GenerateLevelsManual();
      final levels = usecase(
        sets: 5,
        startReps: 1,
        endReps: 5,
        step: 1,
        restSeconds: 60,
        deloadEvery: 2,
        deloadPct: 0.5,
      );
      // Sequence: 1, 2, D, 3, 4, D, 5  => total 7 levels, 2 deloads
      expect(levels.length, 7);
      final deloads = levels.where((l) => l.isDeload).toList();
      expect(deloads.length, 2);
      // First deload after reaching 2 reps -> reduced to 1
      expect(deloads.first.repsPerSet, List<int>.filled(5, 1));
    });
  });

  group('GenerateLevelsManual - ladder', () {
    test('produces micro-steps by upgrading one set at a time', () {
      const usecase = GenerateLevelsManual();
      final levels = usecase(
        sets: 3,
        startReps: 1,
        endReps: 3,
        step: 1,
        restSeconds: 90,
        mode: ManualGenerationMode.ladder,
      );
      // Expected sequence:
      // 1-1-1,
      // 2-1-1, 2-2-1, 2-2-2,
      // 3-2-2, 3-3-2, 3-3-3
      final expected = <List<int>>[
        [1, 1, 1],
        [2, 1, 1],
        [2, 2, 1],
        [2, 2, 2],
        [3, 2, 2],
        [3, 3, 2],
        [3, 3, 3],
      ];
      expect(levels.map((e) => e.repsPerSet).toList(), expected);
      expect(levels.first.index, 1);
      expect(levels.last.index, expected.length);
    });

    test('ladder with deloads inserts reduced rows', () {
      const usecase = GenerateLevelsManual();
      final levels = usecase(
        sets: 2,
        startReps: 1,
        endReps: 3,
        step: 1,
        restSeconds: 30,
        mode: ManualGenerationMode.ladder,
        deloadEvery: 3,
        deloadPct: 0.5,
      );
      // Work levels: 1-1, 2-1, 2-2, 3-2, 3-3
      // => deload after 3rd and after 6th (not present)
      // So there should be a deload inserted after the third work level.
      final deloadIndices = <int>[];
      for (var i = 0; i < levels.length; i++) {
        if (levels[i].isDeload) deloadIndices.add(i);
      }
      expect(deloadIndices.length, 1);
      // Deload row values should be reduced from the preceding work level.
      // (2-2 -> 1-1)
      final reduced = levels[deloadIndices.first].repsPerSet;
      expect(reduced, [1, 1]);
    });
  });
}
