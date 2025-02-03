enum ActivityFrequency {
  everyMeal,
  oneAfterMeal,
  weekly,
}

class Activity {
  final String name;
  final List<Subtask> subtasks;
  final ActivityFrequency frequency;
  final List<Subtask>? additionalSubtasks;

  const Activity({
    required this.name,
    required this.subtasks,
    required this.frequency,
    this.additionalSubtasks,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      name: json['name'],
      subtasks: json['subtasks']
          .map<Subtask>((subtask) => Subtask(name: subtask['name']))
          .toList(),
      additionalSubtasks: json['additionalSubtasks']
          ?.map<Subtask>((subtask) => Subtask(name: subtask['name']))
          .toList(),
      frequency: ActivityFrequency.values[json['frequency']],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'subtasks': subtasks.map((subtask) => subtask.toJson()).toList(),
      'additionalSubtasks':
          additionalSubtasks?.map((subtask) => subtask.toJson()).toList(),
      'frequency': frequency.index,
    };
  }
}

class Subtask {
  final String name;
  final String user;

  const Subtask({required this.name, this.user = 'Everyone'});

  Map<String, dynamic> toJson() => {'name': name, 'user': user};
}
