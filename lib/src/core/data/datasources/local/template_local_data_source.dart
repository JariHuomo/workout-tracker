import 'dart:convert';

import 'package:flutter/services.dart';

class TemplateLocalDataSource {
  TemplateLocalDataSource({AssetBundle? bundle})
      : _bundle = bundle ?? rootBundle;

  final AssetBundle _bundle;

  Future<List<Map<String, dynamic>>> loadTemplates() async {
    final raw = await _bundle.loadString('assets/data/templates_data.json');
    final decoded = json.decode(raw) as Map<String, dynamic>;
    final templates = decoded['templates'] as List<dynamic>? ?? [];
    return templates
        .map<Map<String, dynamic>>(
          (item) => Map<String, dynamic>.from(item as Map),
        )
        .toList();
  }
}
