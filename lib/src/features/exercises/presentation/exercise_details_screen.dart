import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:workouttracker/src/core/application/providers.dart';
import 'package:workouttracker/src/core/domain/entities/exercise.dart';
import 'package:workouttracker/src/core/domain/entities/session.dart';
import 'package:workouttracker/src/features/exercises/application/exercises_notifier.dart';
import 'package:workouttracker/src/features/session/application/session_controller.dart';

class ExerciseDetailsScreen extends ConsumerWidget {
  const ExerciseDetailsScreen({required this.id, super.key});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercisesAsync = ref.watch(exercisesProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise Details')),
      body: exercisesAsync.when(
        data: (items) {
          final ex = items.firstWhere((e) => e.id == id);
          return _ExerciseDetails(ex: ex);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

class _ExerciseDetails extends ConsumerWidget {
  const _ExerciseDetails({required this.ex});
  final Exercise ex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIdx = ex.currentLevelIndex;
    final levelCount = ex.levels.length;
    final currentLevel = levelCount > currentIdx ? ex.levels[currentIdx] : null;
    final templateName = ref.watch(templatesProvider).maybeWhen(
          data: (templates) {
            for (final template in templates) {
              if (template.id == ex.templateId) {
                return template.name;
              }
            }
            return null;
          },
          orElse: () => null,
        );
    final currentLabel = currentLevel == null
        ? ''
        : [
            'L${currentLevel.index.toString().padLeft(2, '0')}',
            currentLevel.repsPerSet.join('-'),
            'Rest ${currentLevel.restSeconds}s',
          ].join('  ');
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(ex.name, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        if (templateName != null) ...[
          Row(
            children: [
              const Icon(Icons.view_list_outlined, size: 20),
              const SizedBox(width: 6),
              Text('Template: $templateName'),
            ],
          ),
          const SizedBox(height: 8),
        ],
        if (currentLevel != null) Text('Current: $currentLabel'),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: ex.levels.isEmpty
              ? null
              : () async {
                  await ref.read(sessionControllerProvider.notifier).start(ex);
                  final state = ref.read(sessionControllerProvider);
                  if (!context.mounted) {
                    return;
                  }
                  final session = state.maybeWhen<WorkoutSession?>(
                    inProgress: (value, _) => value,
                    orElse: () => null,
                  );
                  if (session != null) {
                    await context.push('/session/${session.id}');
                  }
                },
          child: const Text('Start Session'),
        ),
        const SizedBox(height: 24),
        Text('Levels', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        for (var i = 0; i < ex.levels.length; i++)
          Builder(builder: (context) {
            final level = ex.levels[i];
            final deloadIndicator = level.isDeload
                ? Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Chip(
                      label: Text(
                        'Deload',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  )
                : null;
            Widget trailing;
            if (i == currentIdx) {
              trailing = Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Current'),
                  if (deloadIndicator != null) deloadIndicator,
                ],
              );
            } else {
              trailing = Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () async {
                      await ref
                          .read(exercisesProvider.notifier)
                          .setCurrentLevel(ex.id, i);
                    },
                    child: const Text('Set start'),
                  ),
                  if (deloadIndicator != null) deloadIndicator,
                ],
              );
            }
            return ListTile(
              leading: Icon(
                i == currentIdx
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
              ),
              title: Text(
                [
                  'L${level.index.toString().padLeft(2, '0')}',
                  level.repsPerSet.join('-'),
                ].join('  '),
              ),
              subtitle: Text(
                'Sets ${level.repsPerSet.length} • Rest ${level.restSeconds}s',
              ),
              trailing: trailing,
            );
          },),
      ],
    );
  }
}
