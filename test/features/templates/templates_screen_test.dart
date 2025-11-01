import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workouttracker/src/core/application/providers.dart';
import 'package:workouttracker/src/core/domain/entities/template.dart';
import 'package:workouttracker/src/features/templates/presentation/templates_screen.dart';

void main() {
  final template = ProgressionTemplate(
    id: 'standard',
    name: 'Standard',
    description: 'Add 1 rep per week.',
    targetAudience: 'All levels',
    estimatedWeeks: 12,
    deloadFrequency: 4,
    deloadPercentage: 0.33,
    difficulty: 'medium',
    weeks: const [
      WeekProtocol(week: 1, sets: 5, reps: 1),
      WeekProtocol(week: 2, sets: 5, reps: 2),
      WeekProtocol(week: 3, sets: 5, reps: 3),
      WeekProtocol(week: 4, sets: 5, reps: 2, isDeload: true),
    ],
  );

  testWidgets('TemplatesScreen renders templates list', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          templatesProvider.overrideWith(
            (ref) async => [template],
          ),
        ],
        child: const MaterialApp(
          home: TemplatesScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Standard'), findsOneWidget);
    expect(find.textContaining('12 week plan'), findsOneWidget);
    expect(find.textContaining('Add 1 rep per week'), findsOneWidget);
    expect(find.textContaining('Week 1'), findsWidgets);
  });
}
