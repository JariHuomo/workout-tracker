import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:workouttracker/src/core/domain/entities/exercise.dart';
import 'package:workouttracker/src/core/domain/entities/session.dart';
import 'package:workouttracker/src/features/exercises/application/exercise_search_provider.dart';
import 'package:workouttracker/src/features/exercises/application/exercises_notifier.dart';
import 'package:workouttracker/src/features/history/application/last_completed_provider.dart';
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
      appBar: AppBar(
        title: const Text('Exercises'),
        bottom: const PreferredSize(
          // Give enough space for TextField height + padding.
          preferredSize: Size.fromHeight(72),
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: _ExerciseSearchField(),
          ),
        ),
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
        data: (items) {
          final query =
              ref.watch(exerciseSearchQueryProvider).trim().toLowerCase();
          final filtered = query.isEmpty
              ? items
              : items
                  .where((e) => e.name.toLowerCase().contains(query))
                  .toList();

          if (items.isEmpty) {
            return EmptyStateWidget(
              icon: Icons.fitness_center,
              title: 'No Exercises Yet',
              message:
                  'Create your first exercise to start your strength journey',
              actionLabel: 'Create Exercise',
              onAction: () => context.push('/exercises/new'),
            );
          }
          if (filtered.isEmpty) {
            return EmptyStateWidget(
              icon: Icons.search_off,
              title: 'No matches',
              message: query.isEmpty ? '' : 'No exercises match "$query".',
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemBuilder: (c, i) => _ExerciseCard(ex: filtered[i]),
            itemCount: filtered.length,
          );
        },
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

class _ExerciseSearchField extends ConsumerStatefulWidget {
  const _ExerciseSearchField();

  @override
  ConsumerState<_ExerciseSearchField> createState() =>
      _ExerciseSearchFieldState();
}

class _ExerciseSearchFieldState extends ConsumerState<_ExerciseSearchField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final initialValue = ref.read(exerciseSearchQueryProvider);
    _controller = TextEditingController(text: initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(exerciseSearchQueryProvider);
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        hintText: 'Search exercises',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: query.isEmpty
            ? null
            : IconButton(
                tooltip: 'Clear',
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _controller.clear();
                  ref.read(exerciseSearchQueryProvider.notifier).state = '';
                },
              ),
        border: const OutlineInputBorder(),
        isDense: true,
      ),
      onChanged: (value) =>
          ref.read(exerciseSearchQueryProvider.notifier).state = value,
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

    final progress =
        ex.levels.isEmpty ? 0.0 : (ex.currentLevelIndex + 1) / ex.levels.length;

    return ElevatedInfoCard(
      onTap: () => context.push('/exercises/${ex.id}'),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title and level badge
          Row(
            children: [
              if (current != null) ...[
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.deepElectricBlue,
                        AppColors.vibrantPurple,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color:
                            AppColors.deepElectricBlue.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'L${current.index + 1}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 18),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ex.name,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                    ),
                    if (ex.levels.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        'Level ${ex.currentLevelIndex + 1} '
                        'of ${ex.levels.length}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.6),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              PopupMenuButton<String>(
                tooltip: 'More',
                onSelected: (value) async {
                  if (value == 'delete') {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Delete Exercise'),
                        content: Text(
                          'Delete "${ex.name}"? This cannot be undone.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(false),
                            child: const Text('Cancel'),
                          ),
                          FilledButton(
                            onPressed: () => Navigator.of(ctx).pop(true),
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    );
                    if (confirmed ?? false) {
                      await ref.read(exercisesProvider.notifier).delete(ex.id);
                    }
                  }
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(value: 'delete', child: Text('Delete')),
                ],
              ),
            ],
          ),

          const SizedBox(height: 8),
          Consumer(
            builder: (context, ref, _) {
              final lastAsync = ref.watch(lastCompletedByExerciseProvider);
              return lastAsync.maybeWhen(
                data: (map) {
                  final last = map[ex.id];
                  final style = theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  );
                  if (last == null) {
                    return Text('Last done: never', style: style);
                  }
                  final now = DateTime.now();
                  final diff = now.difference(last);
                  final days = diff.inDays;
                  final label = days > 0
                      ? '$days day${days == 1 ? '' : 's'} ago'
                      : 'today';
                  return Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                      const SizedBox(width: 6),
                      Text('Last done: $label', style: style),
                    ],
                  );
                },
                orElse: () => const SizedBox.shrink(),
              );
            },
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
                    color: theme.colorScheme.onErrorContainer,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'No levels defined',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onErrorContainer,
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
            const SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'OVERALL PROGRESS',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.6),
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      '${(progress * 100).round()}%',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: AppColors.deepElectricBlue,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Stack(
                  children: [
                    Container(
                      height: 14,
                      decoration: BoxDecoration(
                        color: theme.brightness == Brightness.dark
                            ? AppColors.carbonGray
                            : AppColors.softGray,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: progress,
                      child: Container(
                        height: 14,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.deepElectricBlue,
                              AppColors.vibrantPurple,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.deepElectricBlue
                                  .withValues(alpha: 0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],

          // Action Button
          Container(
            width: double.infinity,
            decoration: current == null
                ? null
                : BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        AppColors.deepElectricBlue,
                        AppColors.vibrantPurple,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color:
                            AppColors.deepElectricBlue.withValues(alpha: 0.4),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
            child: FilledButton.icon(
              onPressed: current == null
                  ? null
                  : () async {
                      await ref
                          .read(sessionControllerProvider.notifier)
                          .start(ex);
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
              icon: const Icon(Icons.play_arrow, color: Colors.white),
              label: const Text(
                'Start Workout',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  letterSpacing: 0.5,
                ),
              ),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18),
                backgroundColor: current == null ? null : Colors.transparent,
                shadowColor: Colors.transparent,
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? AppColors.carbonGray
            : AppColors.softGray,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'REP SCHEME',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            level.repsPerSet.join('  ·  '),
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
              fontFeatures: const [
                FontFeature.tabularFigures(),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: theme.brightness == Brightness.dark
                      ? AppColors.smokeGray.withValues(alpha: 0.5)
                      : Colors.white.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.fitness_center,
                      size: 16,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${level.repsPerSet.length} sets',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.8),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: theme.brightness == Brightness.dark
                      ? AppColors.smokeGray.withValues(alpha: 0.5)
                      : Colors.white.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      size: 16,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${level.restSeconds}s rest',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.8),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
