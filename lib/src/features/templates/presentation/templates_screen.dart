import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttracker/src/core/application/providers.dart';
import 'package:workouttracker/src/core/domain/entities/template.dart';
import 'package:workouttracker/src/core/domain/failures.dart';

class TemplatesScreen extends ConsumerWidget {
  const TemplatesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final templatesAsync = ref.watch(templatesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progression Templates'),
      ),
      body: templatesAsync.when(
        data: (templates) => _TemplatesList(templates: templates),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) {
          final message = error is Failure
              ? error.message
              : 'Failed to load templates';
          return _TemplatesError(
            message: message,
            onRetry: () => ref.invalidate(templatesProvider),
          );
        },
      ),
    );
  }
}

class _TemplatesList extends StatelessWidget {
  const _TemplatesList({required this.templates});

  final List<ProgressionTemplate> templates;

  @override
  Widget build(BuildContext context) {
    if (templates.isEmpty) {
      return const _TemplatesEmpty();
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: templates.length,
      itemBuilder: (context, index) {
        final template = templates[index];
        return _TemplateCard(template: template);
      },
      separatorBuilder: (_, __) => const SizedBox(height: 12),
    );
  }
}

class _TemplateCard extends StatelessWidget {
  const _TemplateCard({required this.template});

  final ProgressionTemplate template;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final deloadLabel = template.deloadFrequency > 0
        ? 'Deload every ${template.deloadFrequency} weeks'
        : 'No deload';
    final deloadPercent = (template.deloadPercentage * 100).toStringAsFixed(0);
    final difficultyColor = _difficultyColor(context, template.difficulty);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    template.name,
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: difficultyColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    template.difficulty.toUpperCase(),
                    style: theme.textTheme.labelMedium
                        ?.copyWith(color: difficultyColor),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              template.description,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _InfoChip(
                  icon: Icons.calendar_today_outlined,
                  label: '${template.estimatedWeeks} week plan',
                ),
                _InfoChip(
                  icon: Icons.group_outlined,
                  label: template.targetAudience,
                ),
                _InfoChip(
                  icon: Icons.trending_up_outlined,
                  label: deloadLabel,
                ),
                _InfoChip(
                  icon: Icons.pause_circle_outline,
                  label: 'Deload intensity −$deloadPercent%',
                ),
              ],
            ),
            const SizedBox(height: 16),
            _WeeksPreview(weeks: template.weeks.take(4).toList()),
          ],
        ),
      ),
    );
  }

  Color _difficultyColor(BuildContext context, String difficulty) {
    final colors = Theme.of(context).colorScheme;
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return colors.tertiary;
      case 'medium':
        return colors.primary;
      case 'hard':
        return colors.error;
      default:
        return colors.secondary;
    }
  }
}

class _WeeksPreview extends StatelessWidget {
  const _WeeksPreview({required this.weeks});

  final List<WeekProtocol> weeks;

  @override
  Widget build(BuildContext context) {
    if (weeks.isEmpty) {
      return const SizedBox.shrink();
    }
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'First weeks preview',
          style: theme.textTheme.labelLarge,
        ),
        const SizedBox(height: 8),
        Column(
          children: weeks
              .map(
                (week) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  leading: Text('Week ${week.week}'),
                  title: Text('${week.sets} × ${week.reps}'),
                  trailing: week.isDeload
                      ? const Icon(
                          Icons.spa_outlined,
                          size: 18,
                        )
                      : null,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
    );
  }
}

class _TemplatesEmpty extends StatelessWidget {
  const _TemplatesEmpty();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.auto_graph_outlined, size: 48),
            const SizedBox(height: 12),
            Text(
              'No templates available yet',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            const Text('Add templates to start guiding progressions.'),
          ],
        ),
      ),
    );
  }
}

class _TemplatesError extends StatelessWidget {
  const _TemplatesError({required this.message, required this.onRetry});

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
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
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
