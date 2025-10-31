import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:workouttracker/src/core/application/providers.dart';
import 'package:workouttracker/src/core/domain/entities/exercise.dart';
import 'package:workouttracker/src/core/domain/entities/template.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Exercise'),
        actions: [
          TextButton(
            onPressed: _levels.isNotEmpty && _name.text.trim().isNotEmpty
                ? _save
                : null,
            child: const Text('Save'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _name,
            decoration: const InputDecoration(labelText: 'Name'),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          templatesAsync.when(
            data: (templates) => DropdownButtonFormField<String?>(
              value: _selectedTemplate?.id,
              decoration: const InputDecoration(labelText: 'Template'),
              items: [
                const DropdownMenuItem<String?>(
                  value: null,
                  child: Text('No template'),
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
            error: (error, _) => Text(
              'Templates unavailable: $error',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Theme.of(context).colorScheme.error),
            ),
          ),
          if (_selectedTemplate != null) ...[
            const SizedBox(height: 12),
            _TemplateSummary(template: _selectedTemplate!),
          ],
          const SizedBox(height: 12),
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
          const SizedBox(height: 8),
          Row(
            children: [
              FilledButton(
                onPressed: _selectedTemplate != null ||
                        _startReps > _endReps ||
                        _step <= 0
                    ? null
                    : _generate,
                child: const Text('Generate Levels'),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: () => setState(() {
                  _levels = const [];
                  _selectedTemplate = null;
                }),
                child: const Text('Clear'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_levels.isNotEmpty)
            Text(
              'Preview (${_levels.length} levels)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          const SizedBox(height: 8),
          for (final level in _levels)
            ListTile(
              title: Text(
                [
                  'L${level.index.toString().padLeft(2, '0')}',
                  level.repsPerSet.join('-'),
                ].join('  '),
              ),
              subtitle: Text(
                'Sets ${level.repsPerSet.length} • Rest ${level.restSeconds}s',
              ),
              trailing: level.isDeload
                  ? const Chip(
                      label: Text('Deload'),
                    )
                  : null,
            ),
          const SizedBox(height: 12),
          TextField(
            controller: _notes,
            decoration: const InputDecoration(labelText: 'Notes'),
            minLines: 2,
            maxLines: 4,
          ),
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
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              template.name,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(template.description),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(
                  avatar: const Icon(Icons.calendar_today_outlined, size: 18),
                  label: Text('${template.estimatedWeeks} weeks'),
                ),
                Chip(
                  avatar: const Icon(Icons.trending_down_outlined, size: 18),
                  label: Text(deloadLabel),
                ),
                Chip(
                  avatar: const Icon(Icons.speed_outlined, size: 18),
                  label: Text(
                    template.difficulty.toUpperCase(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
