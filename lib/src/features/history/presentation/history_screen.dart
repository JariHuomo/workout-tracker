import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttracker/src/core/application/providers.dart';
import 'package:workouttracker/src/core/domain/entities/exercise.dart';
import 'package:workouttracker/src/core/domain/entities/session.dart';
import 'package:workouttracker/src/core/domain/failures.dart';
import 'package:workouttracker/src/features/history/application/history_sessions_provider.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionsAsync = ref.watch(historySessionsProvider);
    final exercisesAsync = ref.watch(exercisesProvider);
    final exerciseMap = exercisesAsync.maybeWhen(
      data: (items) => {for (final exercise in items) exercise.id: exercise},
      orElse: () => <String, Exercise>{},
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: sessionsAsync.when(
        data: (sessions) => sessions.isEmpty
            ? const _EmptyHistory()
            : RefreshIndicator(
                onRefresh: () async {
                  await ref.refresh(historySessionsProvider.future);
                },
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    final session = sessions[index];
                    final exercise =
                        exerciseMap[session.exerciseId]?.name ?? 'Unknown';
                    return _HistoryTile(
                      session: session,
                      exerciseName: exercise,
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemCount: sessions.length,
                ),
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) {
          final message =
              error is Failure ? error.message : 'Failed to load history';
          return _ErrorState(
            message: message,
            onRetry: () => ref.invalidate(historySessionsProvider),
          );
        },
      ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  const _HistoryTile({
    required this.session,
    required this.exerciseName,
  });

  final WorkoutSession session;
  final String exerciseName;

  @override
  Widget build(BuildContext context) {
    final startedAt = _formatDateTime(session.startedAt);
    final resultLabel = session.passed ? 'Passed' : 'Repeat';
    final resultColor = session.passed
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.error;
    final attemptSummary = session.attempts
        .map((attempt) => '${attempt.reps}')
        .toList()
        .join(', ');
    final target = session.targetRepsPerSet.join(', ');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    exerciseName,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: resultColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    resultLabel,
                    style: TextStyle(color: resultColor),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              startedAt,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 8),
            Text('Target: $target'),
            const SizedBox(height: 4),
            Text(
              attemptSummary.isEmpty
                  ? 'No sets logged'
                  : 'Logged: $attemptSummary',
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime? time) {
    if (time == null) return 'Unknown time';
    final local = time.toLocal();
    final date =
        '${local.year}-${local.month.toString().padLeft(2, '0')}-${local.day.toString().padLeft(2, '0')}';
    final clock =
        '${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
    return '$date $clock';
  }
}

class _EmptyHistory extends StatelessWidget {
  const _EmptyHistory();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.history, size: 48),
            const SizedBox(height: 12),
            Text(
              'No sessions logged yet',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            const Text('Start a workout to see your history here.'),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
