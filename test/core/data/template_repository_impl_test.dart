import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workouttracker/src/core/data/datasources/local/template_local_data_source.dart';
import 'package:workouttracker/src/core/data/repositories/template_repository_impl.dart';

void main() {
  const jsonString = '''
  {
    "templates": [
      {
        "id": "t1",
        "name": "Beginner",
        "description": "Start slow",
        "targetAudience": "Beginners",
        "estimatedWeeks": 8,
        "deloadFrequency": 4,
        "deloadPercentage": 0.25,
        "difficulty": "easy",
        "weeks": [
          {"week": 1, "sets": 5, "reps": 1, "isDeload": false},
          {"week": 2, "sets": 5, "reps": 2, "isDeload": false}
        ]
      }
    ]
  }
  ''';

  test('TemplateRepositoryImpl parses templates from local data source',
      () async {
    final bundle = _FakeBundle(jsonString);
    final dataSource = TemplateLocalDataSource(bundle: bundle);
    final repository = TemplateRepositoryImpl(dataSource);

    final result = await repository.getTemplates();
    expect(result.isRight(), isTrue);

    result.match(
      (_) => fail('Expected success'),
      (templates) {
        expect(templates, hasLength(1));
        final template = templates.first;
        expect(template.id, 't1');
        expect(template.weeks, hasLength(2));
        expect(template.weeks.first.week, 1);
      },
    );
  });
}

class _FakeBundle extends AssetBundle {
  _FakeBundle(this._response);
  final String _response;

  @override
  Future<String> loadString(String key, {bool cache = true}) async => _response;

  @override
  Future<ByteData> load(String key) async => ByteData(0);
}
