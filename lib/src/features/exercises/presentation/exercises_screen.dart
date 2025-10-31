import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:workouttracker/src/core/application/providers.dart';
import 'package:workouttracker/src/core/domain/entities/exercise.dart';
import 'package:workouttracker/src/core/domain/entities/session.dart';
import 'package:workouttracker/src/features/session/application/session_controller.dart';

class ExercisesScreen extends ConsumerWidget {
  const ExercisesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercisesAsync = ref.watch(exercisesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercises'),
        actions: [
          IconButton(
            icon: const Icon(Icons.view_list_outlined),
            tooltip: 'Templates',
            onPressed: () => context.push('/templates'),
          ),
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'History',
            onPressed: () => context.push('/history'),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/exercises/new'),
        child: const Icon(Icons.add),
      ),
      body: exercisesAsync.when(
        data: (items) => items.isEmpty
            ? _EmptyState(onCreate: () => context.push('/exercises/new'))
            : ListView.separated(
                itemBuilder: (c, i) => _ExerciseItem(ex: items[i]),
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemCount: items.length,
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onCreate});
  final VoidCallback onCreate;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('No exercises yet'),
          const SizedBox(height: 8),
          FilledButton(
            onPressed: onCreate,
            child: const Text('Create Exercise'),
          ),
        ],
      ),
    );
  }
}

class _ExerciseItem extends ConsumerWidget {
  const _ExerciseItem({required this.ex});
  final Exercise ex;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current =
        (ex.levels.isEmpty || ex.currentLevelIndex >= ex.levels.length)
            ? null
            : ex.levels[ex.currentLevelIndex];
    final subtitle = current == null
        ? 'No levels defined'
        : [
            'Level L${current.index.toString().padLeft(2, '0')}',
            current.repsPerSet.join('-'),
            'Rest ${current.restSeconds}s',
          ].join('  ');
    return ListTile(
      title: Text(ex.name),
      subtitle: Text(subtitle),
      onTap: () => context.push('/exercises/${ex.id}'),
      trailing: FilledButton(
        onPressed: current == null
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
        child: const Text('Start'),
      ),
    );
  }
}
