class ProgressionTemplate {
  ProgressionTemplate({
    required this.id,
    required this.name,
    required this.description,
    required this.targetAudience,
    required this.estimatedWeeks,
    required this.deloadFrequency,
    required this.deloadPercentage,
    required this.difficulty,
    List<WeekProtocol> weeks = const <WeekProtocol>[],
  }) : weeks = List<WeekProtocol>.unmodifiable(weeks);

  factory ProgressionTemplate.fromJson(Map<String, dynamic> json) {
    return ProgressionTemplate(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      targetAudience: json['targetAudience'] as String? ?? '',
      estimatedWeeks: (json['estimatedWeeks'] as num?)?.toInt() ?? 0,
      deloadFrequency: (json['deloadFrequency'] as num?)?.toInt() ?? 0,
      deloadPercentage: (json['deloadPercentage'] as num?)?.toDouble() ?? 0.0,
      difficulty: json['difficulty'] as String? ?? '',
      weeks: (json['weeks'] as List<dynamic>? ?? [])
          .map((e) => WeekProtocol.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  final String id;
  final String name;
  final String description;
  final String targetAudience;
  final int estimatedWeeks;
  final int deloadFrequency;
  final double deloadPercentage;
  final String difficulty;
  final List<WeekProtocol> weeks;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'targetAudience': targetAudience,
        'estimatedWeeks': estimatedWeeks,
        'deloadFrequency': deloadFrequency,
        'deloadPercentage': deloadPercentage,
        'difficulty': difficulty,
        'weeks': weeks.map((week) => week.toJson()).toList(),
      };
}

class WeekProtocol {
  const WeekProtocol({
    required this.week,
    required this.sets,
    required this.reps,
    this.isDeload = false,
  });

  factory WeekProtocol.fromJson(Map<String, dynamic> json) {
    return WeekProtocol(
      week: (json['week'] as num).toInt(),
      sets: (json['sets'] as num).toInt(),
      reps: (json['reps'] as num).toInt(),
      isDeload: json['isDeload'] as bool? ?? false,
    );
  }

  final int week;
  final int sets;
  final int reps;
  final bool isDeload;

  Map<String, dynamic> toJson() => {
        'week': week,
        'sets': sets,
        'reps': reps,
        'isDeload': isDeload,
      };
}
