import 'dart:io';

/// Simple, heuristic audit for Material ColorScheme container/text pairings.
///
/// Flags cases where a `*Container` color is used nearby without a matching
/// `on*Container` text color. This is a best‑effort static check meant to
/// catch obvious contrast issues before review.
///
/// Run: dart run tool/contrast_audit.dart
void main() {
  final root = Directory('lib');
  if (!root.existsSync()) {
    stderr.writeln('lib/ not found. Run from project root.');
    exitCode = 2;
    return;
  }

  final roles = <String, String>{
    'primaryContainer': 'onPrimaryContainer',
    'secondaryContainer': 'onSecondaryContainer',
    'tertiaryContainer': 'onTertiaryContainer',
    'errorContainer': 'onErrorContainer',
  };

  final files = root
      .listSync(recursive: true)
      .whereType<File>()
      .where((file) => file.path.endsWith('.dart'))
      .toList();

  var issues = 0;
  for (final file in files) {
    final lines = file.readAsLinesSync();
    for (var i = 0; i < lines.length; i++) {
      final line = lines[i];
      for (final entry in roles.entries) {
        if (line.contains(entry.key)) {
          final start = (i - 20).clamp(0, lines.length - 1);
          final end = (i + 20).clamp(0, lines.length - 1);
          final window = lines.sublist(start, end + 1).join('\n');

          // If companion on*Container not found nearby, warn.
          final hasOn = window.contains(entry.value);
          if (!hasOn) {
            issues++;
            stdout.writeln(
              '[warn] ${file.path}:${i + 1} uses ${entry.key} '
              'without nearby ${entry.value}',
            );
          }

          // Strong signal: primaryContainer near `.colorScheme.primary` text.
          if (entry.key == 'primaryContainer' &&
              window.contains('colorScheme.primary') &&
              !window.contains('onPrimaryContainer')) {
            issues++;
            stdout.writeln(
              '[warn] ${file.path}:${i + 1} primaryContainer near primary text '
              '— consider onPrimaryContainer',
            );
          }
        }
      }
    }
  }

  if (issues == 0) {
    stdout.writeln(
      'Contrast audit: no obvious container/text pairing issues found.',
    );
  } else {
    stdout.writeln(
      'Contrast audit: $issues potential issue(s) flagged. Review recommended.',
    );
  }
}
