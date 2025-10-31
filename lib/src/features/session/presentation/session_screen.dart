import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:workouttracker/src/core/application/providers.dart';
import 'package:workouttracker/src/core/domain/entities/exercise.dart';
import 'package:workouttracker/src/core/domain/entities/session.dart';
import 'package:workouttracker/src/core/domain/failures.dart';
import 'package:workouttracker/src/features/session/application/session_controller.dart';

class SessionScreen extends ConsumerStatefulWidget {
  const SessionScreen({required this.sessionId, super.key});
  final String sessionId;

  @override
  ConsumerState<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends ConsumerState<SessionScreen>
    with WidgetsBindingObserver {
  late final TextEditingController _customRepsController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _customRepsController = TextEditingController();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _customRepsController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.read(sessionControllerProvider.notifier).syncWithClock();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(sessionControllerProvider);
    final exercises = ref.watch(exercisesProvider).maybeWhen(
          data: (items) => items,
          orElse: () => <Exercise>[],
        );

    return Scaffold(
      appBar: AppBar(title: const Text('Session')),
      body: state.when(
        idle: () => const _CenteredMessage(text: 'No active session'),
        inProgress: (session, currentSetIndex) => _InProgressView(
          session: session,
          currentSetIndex: currentSetIndex,
          onLogExact: () => ref
              .read(sessionControllerProvider.notifier)
              .logSet(reps: session.targetRepsPerSet[currentSetIndex]),
          onLogDelta: (delta) =>
              ref.read(sessionControllerProvider.notifier).logSet(
                    reps: (session.targetRepsPerSet[currentSetIndex] + delta)
                        .clamp(0, 999),
                  ),
          onLogCustom: () {
            final value = int.tryParse(_customRepsController.text) ?? 0;
            ref
                .read(sessionControllerProvider.notifier)
                .logSet(reps: value.clamp(0, 999));
            _customRepsController.clear();
          },
          customRepsController: _customRepsController,
        ),
        resting: (session, nextSetIndex, restEndsAt, remainingSeconds) =>
            _RestingView(
          session: session,
          nextSetIndex: nextSetIndex,
          remainingSeconds: remainingSeconds,
          restEndsAt: restEndsAt,
          onAdjust: (delta) =>
              ref.read(sessionControllerProvider.notifier).adjustRest(delta),
          onSkip: () => ref.read(sessionControllerProvider.notifier).skipRest(),
        ),
        completed: (session) {
          final exercise = exercises.firstWhere(
            (item) => item.id == session.exerciseId,
            orElse: () => const Exercise(id: '', name: ''),
          );
          return _CompletedView(
            session: session,
            exercise: exercise,
            onAdvance: exercise.id.isEmpty
                ? null
                : () async {
                    final result = await ref
                        .read(exercisesProvider.notifier)
                        .advanceLevel(exercise);
                    result.match(
                      (failure) => _showSnackBar(context, failure.message),
                      (_) {
                        _showSnackBar(context, 'Advanced to next level');
                        Navigator.of(context).maybePop();
                      },
                    );
                  },
          );
        },
        failure: (failure) => _FailureView(
          failure: failure,
          onDismiss: () => Navigator.of(context).maybePop(),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}

class _InProgressView extends StatelessWidget {
  const _InProgressView({
    required this.session,
    required this.currentSetIndex,
    required this.onLogExact,
    required this.onLogDelta,
    required this.onLogCustom,
    required this.customRepsController,
  });

  final WorkoutSession session;
  final int currentSetIndex;
  final VoidCallback onLogExact;
  final void Function(int delta) onLogDelta;
  final VoidCallback onLogCustom;
  final TextEditingController customRepsController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final target = session.targetRepsPerSet[currentSetIndex];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Set indicator
          Text(
            'Set ${currentSetIndex + 1} of ${session.targetRepsPerSet.length}',
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),

          // Target display
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: theme.brightness == Brightness.dark
                  ? const Color(0xFF2A2A2A)
                  : const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: theme.colorScheme.primary.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Column(
              children: [
                Text(
                  'TARGET REPS',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$target',
                  style: theme.textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: theme.colorScheme.primary,
                    height: 1.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Primary action
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onLogExact,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20),
                backgroundColor: theme.colorScheme.primary,
              ),
              child: Text(
                'Log $target Reps',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Quick adjustments
          Text(
            'QUICK ADJUST',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => onLogDelta(-1),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    '${target - 1}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => onLogDelta(1),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    '${target + 1}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Custom input
          Text(
            'CUSTOM REPS',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextField(
                  controller: customRepsController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter reps',
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 18,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 3,
                child: FilledButton.tonal(
                  onPressed: onLogCustom,
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                  ),
                  child: const Text(
                    'Log Custom',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Set status
          Text(
            'SET PROGRESS',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          _SetStatus(
            session: session,
            highlightUntil: currentSetIndex,
          ),
        ],
      ),
    );
  }
}

class _RestingView extends StatelessWidget {
  const _RestingView({
    required this.session,
    required this.nextSetIndex,
    required this.remainingSeconds,
    required this.restEndsAt,
    required this.onAdjust,
    required this.onSkip,
  });

  final WorkoutSession session;
  final int nextSetIndex;
  final int remainingSeconds;
  final DateTime restEndsAt;
  final void Function(int deltaSeconds) onAdjust;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final nextTarget = session.targetRepsPerSet[nextSetIndex];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Rest label
          Text(
            'REST PERIOD',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 24),

          // Timer display
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
            decoration: BoxDecoration(
              color: theme.brightness == Brightness.dark
                  ? const Color(0xFF2A2A2A)
                  : const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: theme.colorScheme.tertiary.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Column(
              children: [
                Text(
                  _format(remainingSeconds),
                  style: theme.textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 72,
                    color: theme.colorScheme.tertiary,
                    height: 1.0,
                    fontFeatures: const [
                      FontFeature.tabularFigures(),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Ends at ${TimeOfDay.fromDateTime(restEndsAt).format(context)}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Time adjustment controls
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => onAdjust(-15),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                  ),
                  child: const Text(
                    '−15s',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => onAdjust(15),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                  ),
                  child: const Text(
                    '+15s',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Skip button
          SizedBox(
            width: double.infinity,
            child: FilledButton.tonal(
              onPressed: onSkip,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18),
              ),
              child: const Text(
                'Skip Rest',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Next set info
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer.withOpacity(0.3),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: theme.colorScheme.primary.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'NEXT UP',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      'Set ${nextSetIndex + 1}',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '$nextTarget reps',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Set status
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'SET PROGRESS',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 12),
          _SetStatus(
            session: session,
            highlightUntil: nextSetIndex - 1,
          ),
        ],
      ),
    );
  }

  String _format(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }
}

class _CompletedView extends StatelessWidget {
  const _CompletedView({
    required this.session,
    required this.exercise,
    required this.onAdvance,
  });

  final WorkoutSession session;
  final Exercise exercise;
  final Future<void> Function()? onAdvance;

  bool get _canAdvance =>
      onAdvance != null &&
      exercise.levels.isNotEmpty &&
      exercise.currentLevelIndex < exercise.levels.length - 1;

  @override
  Widget build(BuildContext context) {
    final status = session.passed ? 'Passed 🎉' : 'Not passed';
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Session complete',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(status),
          const SizedBox(height: 24),
          if (session.passed && _canAdvance)
            FilledButton(
              onPressed: onAdvance,
              child: const Text('Advance Level'),
            )
          else if (session.passed && !_canAdvance)
            const Text(
              'You are already at the highest level for this exercise.',
            ),
        ],
      ),
    );
  }
}

class _FailureView extends StatelessWidget {
  const _FailureView({required this.failure, required this.onDismiss});
  final Failure failure;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              color: Theme.of(context).colorScheme.error,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              failure.message,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onDismiss,
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SetStatus extends StatelessWidget {
  const _SetStatus({required this.session, required this.highlightUntil});
  final WorkoutSession session;
  final int highlightUntil;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (var i = 0; i < session.targetRepsPerSet.length; i++)
          _SetChip(
            index: i,
            label: _labelFor(i),
            target: session.targetRepsPerSet[i],
            attempt: session.attempts
                .where((a) => a.setIndex == i)
                .cast()
                .toList()
                .firstOrNull,
            isActive: i == highlightUntil,
            theme: theme,
          ),
      ],
    );
  }

  String _labelFor(int index) {
    final target = session.targetRepsPerSet[index];
    final attempt = session.attempts
        .where((a) => a.setIndex == index)
        .cast()
        .toList();
    if (attempt.isEmpty) {
      return '$target';
    }
    final reps = attempt.first.reps;
    if (reps == target) {
      return '$target';
    }
    if (reps > target) {
      final over = reps - target;
      return '$target (+$over)';
    }
    return '$reps/$target';
  }
}

class _SetChip extends StatelessWidget {
  const _SetChip({
    required this.index,
    required this.label,
    required this.target,
    required this.attempt,
    required this.isActive,
    required this.theme,
  });

  final int index;
  final String label;
  final int target;
  final dynamic attempt;
  final bool isActive;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final isCompleted = attempt != null;
    final isPassed = isCompleted && attempt.reps >= target;
    final isFailed = isCompleted && attempt.reps < target;

    Color backgroundColor;
    Color textColor;
    Color? borderColor;
    IconData? icon;

    if (isPassed) {
      backgroundColor = Colors.green.withOpacity(0.15);
      textColor = Colors.green.shade700;
      borderColor = Colors.green.withOpacity(0.3);
      icon = Icons.check_circle;
    } else if (isFailed) {
      backgroundColor = Colors.red.withOpacity(0.12);
      textColor = Colors.red.shade700;
      borderColor = Colors.red.withOpacity(0.3);
      icon = Icons.warning_rounded;
    } else if (isActive) {
      backgroundColor = theme.colorScheme.primaryContainer;
      textColor = theme.colorScheme.primary;
      borderColor = theme.colorScheme.primary.withOpacity(0.5);
      icon = Icons.play_arrow;
    } else {
      backgroundColor = theme.brightness == Brightness.dark
          ? const Color(0xFF2A2A2A)
          : const Color(0xFFF5F5F5);
      textColor = theme.colorScheme.onSurface.withOpacity(0.6);
      borderColor = null;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: borderColor != null
            ? Border.all(color: borderColor, width: 2)
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: textColor),
            const SizedBox(width: 6),
          ],
          Text(
            'Set ${index + 1}',
            style: theme.textTheme.labelMedium?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: textColor.withOpacity(0.8),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _CenteredMessage extends StatelessWidget {
  const _CenteredMessage({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(text));
  }
}
