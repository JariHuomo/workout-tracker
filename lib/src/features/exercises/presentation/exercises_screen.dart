import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:workouttracker/src/core/application/providers.dart';
import 'package:workouttracker/src/core/domain/entities/exercise.dart';
import 'package:workouttracker/src/core/domain/entities/session.dart';
import 'package:workouttracker/src/features/session/application/session_controller.dart';
import 'package:workouttracker/src/theme/app_theme.dart';
import 'package:workouttracker/src/theme/custom_widgets.dart';

class ExercisesScreen extends ConsumerWidget {
  const ExercisesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercisesAsync = ref.watch(exercisesProvider);
    final theme = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: const Text('Exercises'),
        actions: [
          IconButton(
            icon: const Icon(Icons.view_list_outlined),
            tooltip: 'Templates',
            onPressed: () => context.push('/templates'),
            style: IconButton.styleFrom(
              backgroundColor: theme.colorScheme.surface,
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'History',
            onPressed: () => context.push('/history'),
            style: IconButton.styleFrom(
              backgroundColor: theme.colorScheme.surface,
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () => context.push('/settings'),
            style: IconButton.styleFrom(
              backgroundColor: theme.colorScheme.surface,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/exercises/new'),
        icon: const Icon(Icons.add),
        label: const Text('New Exercise'),
      ),
      body: exercisesAsync.when(
        data: (items) => items.isEmpty
            ? EmptyStateWidget(
                icon: Icons.fitness_center,
                title: 'No Exercises Yet',
                message:
                    'Create your first exercise to start your strength journey',
                actionLabel: 'Create Exercise',
                onAction: () => context.push('/exercises/new'),
              )
            : ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemBuilder: (c, i) => _ExerciseCard(ex: items[i]),
                itemCount: items.length,
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => EmptyStateWidget(
          icon: Icons.error_outline,
          title: 'Error Loading Exercises',
          message: e.toString(),
        ),
      ),
    );
  }
}

class _ExerciseCard extends ConsumerWidget {
  const _ExerciseCard({required this.ex});
  final Exercise ex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final current =
        (ex.levels.isEmpty || ex.currentLevelIndex >= ex.levels.length)
            ? null
            : ex.levels[ex.currentLevelIndex];

    final progress = ex.levels.isEmpty
        ? 0.0
        : (ex.currentLevelIndex + 1) / ex.levels.length;

    return ElevatedInfoCard(
      onTap: () => context.push('/exercises/${ex.id}'),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title and level badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (current != null) ...[
                LevelBadge(
                  levelIndex: current.index,
                  isActive: true,
                  size: 48,
                ),
                const SizedBox(width: 16),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ex.name,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (ex.levels.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Level ${ex.currentLevelIndex + 1} of ${ex.levels.length}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),

          if (current == null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: theme.colorScheme.error,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'No levels defined',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.error,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Current level details
          if (current != null) ...[
            const SizedBox(height: 20),
            _CurrentLevelInfo(level: current),
          ],

          // Progress Bar
          if (ex.levels.isNotEmpty) ...[
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Overall Progress',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 12,
                    backgroundColor: theme.brightness == Brightness.dark
                        ? AppColors.carbonGray
                        : AppColors.softGray,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.deepElectricBlue,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],

          // Action Button
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
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
              icon: const Icon(Icons.play_arrow),
              label: const Text('Start Workout'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CurrentLevelInfo extends StatelessWidget {
  const _CurrentLevelInfo({required this.level});

  final Level level;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? AppColors.carbonGray
            : AppColors.softGray,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rep Scheme',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            level.repsPerSet.join(' - '),
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              fontFeatures: const [
                FontFeature.tabularFigures(),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.fitness_center,
                size: 16,
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
              const SizedBox(width: 6),
              Text(
                '${level.repsPerSet.length} sets',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 16),
              Icon(
                Icons.timer_outlined,
                size: 16,
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
              const SizedBox(width: 6),
              Text(
                '${level.restSeconds}s rest',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
