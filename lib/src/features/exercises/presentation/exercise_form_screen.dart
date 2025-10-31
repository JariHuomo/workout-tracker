import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:workouttracker/src/core/application/providers.dart';
import 'package:workouttracker/src/core/domain/entities/exercise.dart';
import 'package:workouttracker/src/core/domain/entities/template.dart';
import 'package:workouttracker/src/theme/app_theme.dart';
import 'package:workouttracker/src/theme/custom_widgets.dart';

class ExerciseFormScreen extends ConsumerStatefulWidget {
  const ExerciseFormScreen({super.key});

  @override
  ConsumerState<ExerciseFormScreen> createState() => _ExerciseFormScreenState();
}

class _ExerciseFormScreenState extends ConsumerState<ExerciseFormScreen> {
  late final TextEditingController _name;
  late final TextEditingController _notes;
  late final TextEditingController _setsController;
  late final TextEditingController _restController;
  late final TextEditingController _startRepsController;
  late final TextEditingController _endRepsController;
  late final TextEditingController _stepController;

  int _sets = 5;
  int _startReps = 1;
  int _endReps = 5;
  int _step = 1;
  int _rest = 90;
  List<Level> _levels = const [];
  ProgressionTemplate? _selectedTemplate;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _notes = TextEditingController();
    _setsController = TextEditingController(text: _sets.toString());
    _restController = TextEditingController(text: _rest.toString());
    _startRepsController = TextEditingController(text: _startReps.toString());
    _endRepsController = TextEditingController(text: _endReps.toString());
    _stepController = TextEditingController(text: _step.toString());
  }

  void _applyTemplate(ProgressionTemplate template) {
    final generator = ref.read(generateLevelsFromTemplateProvider);
    final levels = generator(
      template: template,
      restSeconds: _rest,
    );
    setState(() {
      _selectedTemplate = template;
      _levels = levels;
    });
  }

  @override
  void dispose() {
    _name.dispose();
    _notes.dispose();
    _setsController.dispose();
    _restController.dispose();
    _startRepsController.dispose();
    _endRepsController.dispose();
    _stepController.dispose();
    super.dispose();
  }

  void _generate() {
    final levels = <Level>[];
    var idx = 1;
    for (var reps = _startReps; reps <= _endReps; reps += _step) {
      levels.add(
        Level(
          index: idx,
          repsPerSet: List.filled(_sets, reps),
          restSeconds: _rest,
        ),
      );
      idx++;
    }
    setState(() {
      _selectedTemplate = null;
      _levels = levels;
    });
  }

  Future<void> _save() async {
    if (_levels.isEmpty) return;
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final firstActiveIndex =
        _levels.indexWhere((level) => level.isDeload == false);
    final ex = Exercise(
      id: id,
      name: _name.text.trim(),
      templateId: _selectedTemplate?.id,
      levels: _levels,
      currentLevelIndex: firstActiveIndex == -1 ? 0 : firstActiveIndex,
      notes: _notes.text,
    );
    await ref.read(exercisesProvider.notifier).upsert(ex);
    if (mounted) context.pop();
  }

  Widget _buildNumberField({
    required String label,
    required TextEditingController controller,
    required int min,
    required int max,
    required ValueChanged<int> setter,
    bool enabled = true,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      enabled: enabled,
      decoration: InputDecoration(labelText: label),
      onChanged: (_) {
        final parsed = int.tryParse(controller.text);
        if (parsed == null) {
          return;
        }
        final sanitized = parsed.clamp(min, max).toInt();
        if (sanitized != parsed) {
          controller
            ..text = sanitized.toString()
            ..selection = TextSelection.collapsed(
              offset: controller.text.length,
            );
        }
        setState(() {
          setter(sanitized);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final templatesAsync = ref.watch(templatesProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Exercise'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilledButton.icon(
              onPressed: _levels.isNotEmpty && _name.text.trim().isNotEmpty
                  ? _save
                  : null,
              icon: const Icon(Icons.check, size: 20),
              label: const Text('Save'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          // Exercise Name Section
          const SectionHeader(
            title: 'Exercise Details',
            subtitle: 'Name your exercise and configure the progression',
            padding: EdgeInsets.only(left: 0, right: 0, top: 8, bottom: 16),
          ),
          TextField(
            controller: _name,
            decoration: const InputDecoration(
              labelText: 'Exercise Name',
              hintText: 'e.g., Pull-ups, Handstand Push-ups',
              prefixIcon: Icon(Icons.fitness_center),
            ),
            style: theme.textTheme.bodyLarge,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 24),
          // Template Selection Card
          ElevatedInfoCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const IconBadge(
                      icon: Icons.view_list_outlined,
                      size: 40,
                      iconSize: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Progression Template',
                            style: theme.textTheme.titleMedium,
                          ),
                          Text(
                            'Use a pre-built progression plan',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                templatesAsync.when(
                  data: (templates) => DropdownButtonFormField<String?>(
                    value: _selectedTemplate?.id,
                    decoration: const InputDecoration(
                      labelText: 'Select Template',
                      prefixIcon: Icon(Icons.architecture),
                    ),
                    items: [
                      const DropdownMenuItem<String?>(
                        value: null,
                        child: Text('No template (manual)'),
                      ),
                      ...templates.map(
                        (template) => DropdownMenuItem<String?>(
                          value: template.id,
                          child: Text(template.name),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      if (value == null) {
                        setState(() {
                          _selectedTemplate = null;
                          _levels = const [];
                        });
                        return;
                      }
                      final template = templates.firstWhere(
                        (element) => element.id == value,
                      );
                      _applyTemplate(template);
                    },
                  ),
                  loading: () => const LinearProgressIndicator(),
                  error: (error, _) => Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: theme.colorScheme.error,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Templates unavailable',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.error,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_selectedTemplate != null) ...[
            const SizedBox(height: 16),
            _TemplateSummary(template: _selectedTemplate!),
          ],
          const SizedBox(height: 24),

          // Manual Configuration Section
          const SectionHeader(
            title: 'Level Configuration',
            subtitle: 'Define sets, reps, and rest periods',
            padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 16),
          ),
          Row(
            children: [
              Expanded(
                child: _buildNumberField(
                  label: 'Sets',
                  controller: _setsController,
                  min: 1,
                  max: 999,
                  setter: (value) => _sets = value,
                  enabled: _selectedTemplate == null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildNumberField(
                  label: 'Rest (s)',
                  controller: _restController,
                  min: 1,
                  max: 3600,
                  setter: (value) {
                    _rest = value;
                    _levels = [
                      for (final level in _levels)
                        level.copyWith(restSeconds: value),
                    ];
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildNumberField(
                  label: 'Start reps',
                  controller: _startRepsController,
                  min: 1,
                  max: 999,
                  setter: (value) => _startReps = value,
                  enabled: _selectedTemplate == null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildNumberField(
                  label: 'End reps',
                  controller: _endRepsController,
                  min: 1,
                  max: 999,
                  setter: (value) => _endReps = value,
                  enabled: _selectedTemplate == null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildNumberField(
                  label: 'Step',
                  controller: _stepController,
                  min: 1,
                  max: 999,
                  setter: (value) => _step = value,
                  enabled: _selectedTemplate == null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: FilledButton.icon(
                  onPressed: _selectedTemplate != null ||
                          _startReps > _endReps ||
                          _step <= 0
                      ? null
                      : _generate,
                  icon: const Icon(Icons.auto_awesome),
                  label: const Text('Generate Levels'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => setState(() {
                    _levels = const [];
                    _selectedTemplate = null;
                  }),
                  icon: const Icon(Icons.clear),
                  label: const Text('Clear'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          if (_levels.isNotEmpty) ...[
            SectionHeader(
              title: 'Level Preview',
              subtitle: '${_levels.length} levels generated',
              padding: const EdgeInsets.only(left: 0, right: 0, bottom: 12),
            ),
            ..._levels.map((level) => _LevelPreviewCard(level: level)),
          ],
          const SizedBox(height: 24),
          const SectionHeader(
            title: 'Additional Notes',
            padding: EdgeInsets.only(left: 0, right: 0, bottom: 12),
          ),
          TextField(
            controller: _notes,
            decoration: const InputDecoration(
              labelText: 'Notes (optional)',
              hintText: 'Add any form cues, tips, or modifications...',
              prefixIcon: Icon(Icons.notes),
            ),
            minLines: 3,
            maxLines: 5,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _TemplateSummary extends StatelessWidget {
  const _TemplateSummary({required this.template});

  final ProgressionTemplate template;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final deloadLabel = template.deloadFrequency > 0
        ? 'Deload every ${template.deloadFrequency} weeks'
        : 'No deload';

    return GradientCard(
      gradient: AppColors.accentGradient,
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  template.difficulty.toUpperCase(),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const Spacer(),
              Icon(
                Icons.check_circle,
                color: Colors.white.withOpacity(0.9),
                size: 24,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            template.name,
            style: theme.textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            template.description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _TemplateMetric(
                icon: Icons.calendar_today_outlined,
                label: '${template.estimatedWeeks} weeks',
              ),
              const SizedBox(width: 20),
              _TemplateMetric(
                icon: Icons.trending_down_outlined,
                label: deloadLabel,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TemplateMetric extends StatelessWidget {
  const _TemplateMetric({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.white.withOpacity(0.9),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: Colors.white.withOpacity(0.9),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _LevelPreviewCard extends StatelessWidget {
  const _LevelPreviewCard({required this.level});

  final Level level;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ElevatedInfoCard(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          LevelBadge(
            levelIndex: level.index,
            isDeload: level.isDeload,
            size: 56,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  level.repsPerSet.join('-'),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontFeatures: const [
                      FontFeature.tabularFigures(),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.fitness_center,
                      size: 14,
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${level.repsPerSet.length} sets',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      Icons.timer_outlined,
                      size: 14,
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${level.restSeconds}s rest',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (level.isDeload)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.warningAmber.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.warningAmber,
                  width: 1.5,
                ),
              ),
              child: Text(
                'DELOAD',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: AppColors.warningAmber,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
