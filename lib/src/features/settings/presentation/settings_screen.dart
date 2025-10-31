import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:workouttracker/src/core/application/providers.dart';
import 'package:workouttracker/src/core/domain/entities/timer.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(timerSettingsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: settingsAsync.when(
        data: (s) => _SettingsForm(settings: s),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

class _SettingsForm extends ConsumerStatefulWidget {
  const _SettingsForm({required this.settings});
  final TimerSettings settings;
  @override
  ConsumerState<_SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends ConsumerState<_SettingsForm> {
  late int rest = widget.settings.defaultRestSeconds;
  late bool precise = widget.settings.preciseAlarms;
  late CountdownBeeps beeps = widget.settings.beeps;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Timer', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration:
                    const InputDecoration(labelText: 'Default Rest (s)'),
                keyboardType: TextInputType.number,
                controller: TextEditingController(text: rest.toString()),
                onChanged: (v) => rest = int.tryParse(v) ?? rest,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SwitchListTile(
          value: precise,
          onChanged: (v) => setState(() => precise = v),
          title: const Text('Precise Alarms (Android 12+)'),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<CountdownBeeps>(
          value: beeps,
          decoration: const InputDecoration(labelText: 'Countdown beeps'),
          items: CountdownBeeps.values
              .map((e) => DropdownMenuItem(value: e, child: Text(_label(e))))
              .toList(),
          onChanged: (v) => setState(() => beeps = v ?? beeps),
        ),
        const SizedBox(height: 24),
        FilledButton(
          onPressed: () async {
            final messenger = ScaffoldMessenger.of(context);
            final updated = TimerSettings(
              defaultRestSeconds: rest,
              preciseAlarms: precise,
              beeps: beeps,
            );
            await ref.read(timerSettingsProvider.notifier).save(updated);
            if (!mounted) {
              return;
            }
            messenger
                .showSnackBar(const SnackBar(content: Text('Saved')));
          },
          child: const Text('Save'),
        ),
      ],
    );
  }

  String _label(CountdownBeeps e) {
    switch (e) {
      case CountdownBeeps.off:
        return 'Off';
      case CountdownBeeps.last3:
        return 'Last 3s';
      case CountdownBeeps.last10:
        return 'Last 10s';
    }
  }
}
