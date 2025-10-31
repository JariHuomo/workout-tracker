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
    final target = session.targetRepsPerSet[currentSetIndex];
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Set ${currentSetIndex + 1} of ${session.targetRepsPerSet.length}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text('Target: $target reps'),
          const SizedBox(height: 24),
          Row(
            children: [
              FilledButton(
                onPressed: onLogExact,
                child: Text('Log $target'),
              ),
              const SizedBox(width: 12),
              OutlinedButton(
                onPressed: () => onLogDelta(-1),
                child: const Text('−1'),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: () => onLogDelta(1),
                child: const Text('+1'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              SizedBox(
                width: 104,
                child: TextField(
                  controller: customRepsController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Custom'),
                ),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: onLogCustom,
                child: const Text('Log custom'),
              ),
            ],
          ),
          const SizedBox(height: 24),
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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Rest', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            _format(remainingSeconds),
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Ends at ${TimeOfDay.fromDateTime(restEndsAt).format(context)}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              OutlinedButton(
                onPressed: () => onAdjust(-15),
                child: const Text('−15s'),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: () => onAdjust(15),
                child: const Text('+15s'),
              ),
              const SizedBox(width: 8),
              TextButton(onPressed: onSkip, child: const Text('Skip')),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Next: Set ${nextSetIndex + 1} — target '
            '${session.targetRepsPerSet[nextSetIndex]} reps',
          ),
          const SizedBox(height: 16),
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
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (var i = 0; i < session.targetRepsPerSet.length; i++)
          Chip(
            label: Text('Set ${i + 1}: ${_labelFor(i)}'),
            backgroundColor:
                i <= highlightUntil ? Colors.green.withOpacity(0.15) : null,
          ),
      ],
    );
  }

  String _labelFor(int index) {
    final attempt = session.attempts.where((a) => a.setIndex == index).toList();
    if (attempt.isEmpty) {
      return '${session.targetRepsPerSet[index]}';
    }
    return '${attempt.first.reps}/${session.targetRepsPerSet[index]}';
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
