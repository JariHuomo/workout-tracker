import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:workouttracker/src/core/application/providers.dart';
import 'package:workouttracker/src/core/domain/entities/timer.dart';
import 'package:workouttracker/src/core/domain/failures.dart';
import 'package:workouttracker/src/core/domain/repositories/prefs_repository.dart';
import 'package:workouttracker/src/features/settings/presentation/settings_screen.dart';

void main() {
  testWidgets('SettingsScreen loads and saves timer settings', (tester) async {
    final repo = _MemoryPrefsRepository(
      const TimerSettings(defaultRestSeconds: 45),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          prefsRepositoryProvider.overrideWithValue(repo),
        ],
        child: const MaterialApp(home: SettingsScreen()),
      ),
    );

    await tester.pumpAndSettle();

    // Default rest field shows initial value
    expect(find.widgetWithText(TextField, 'Default Rest (s)'), findsOneWidget);
    expect(find.text('45'), findsOneWidget);

    // Toggle precise alarms and change rest to 60
    await tester.enterText(find.byType(TextField), '60');
    await tester.pump();
    await tester.tap(
        find.widgetWithText(SwitchListTile, 'Precise Alarms (Android 12+)'),);
    await tester.pump();

    await tester.tap(find.widgetWithText(FilledButton, 'Save'));
    await tester.pumpAndSettle();

    expect(repo.saved?.defaultRestSeconds, 60);
    expect(repo.saved?.preciseAlarms, isTrue);
  });
}

class _MemoryPrefsRepository implements PrefsRepository {
  _MemoryPrefsRepository(this._settings);
  TimerSettings _settings;
  TimerSettings? saved;

  @override
  Future<Either<Failure, TimerSettings>> loadTimerSettings() async =>
      Right(_settings);

  @override
  Future<Either<Failure, Unit>> saveTimerSettings(
    TimerSettings settings,
  ) async {
    saved = settings;
    _settings = settings;
    return const Right(unit);
  }
}
