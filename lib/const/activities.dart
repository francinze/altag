enum ActivityFrequency {
  everyMeal,
  oneAfterMeal,
  weekly,
}

class Activity {
  final String name;
  final List<Subtask> subtasks;
  final ActivityFrequency frequency;

  const Activity({
    required this.name,
    required this.subtasks,
    required this.frequency,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      name: json['name'],
      subtasks: json['subtasks']
          .map<Subtask>((subtask) => Subtask(name: subtask['name']))
          .toList(),
      frequency: ActivityFrequency.values[json['frequency']],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'subtasks': subtasks.map((subtask) => subtask.toJson()).toList(),
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

// Hardcoded activities list
const List<Activity> activities = [
  // Activity done by everyone after every meal
  Activity(
    name: 'Pulizia post pasto',
    subtasks: [
      Subtask(name: 'Check Vestiti'),
      Subtask(name: 'Svuota briciole'),
      Subtask(name: 'Pulizia banco'),
      Subtask(name: 'Pulizia piano induzione'),
      Subtask(name: 'Pulizia tavolo'),
      Subtask(name: 'Piatti in lavastoviglie'),
      Subtask(name: 'Panno nero per induzione'),
      Subtask(name: 'Vitamine', user: 'Gabriele'),
      Subtask(name: 'Stretching', user: 'Francesco'),
    ],
    frequency: ActivityFrequency.everyMeal,
  ),
  // Activity done once per meal (by one person) after dinner
  Activity(
    name: 'Pulizia cucina Turnata',
    subtasks: [
      Subtask(name: 'Avvia Lavastoviglie'),
      Subtask(name: 'Check vetro'),
      Subtask(name: 'Check indifferenziato'),
      Subtask(name: 'Check organico'),
      Subtask(name: 'Pezza su bidoni'),
      Subtask(name: 'Passata aspirapolvere'),
      Subtask(name: 'Mettere pezze e tovaglie sporche in lavatrice'),
      Subtask(name: 'Svuota lavastoviglie pulita'),
      Subtask(name: 'Metti aspirapolvere in carica'),
      Subtask(name: 'Riordina aspirapolvere carico'),
      Subtask(name: 'Liberare pavimenti'),
    ],
    frequency: ActivityFrequency.oneAfterMeal,
  ),
  Activity(
    name: 'Pulizia bagno',
    subtasks: [
      Subtask(name: 'Bidet'),
      Subtask(name: 'Water'),
      Subtask(name: 'Lavabo + sturare se intasato'),
      Subtask(name: 'Check cestino'),
    ],
    frequency: ActivityFrequency.weekly,
  ),
  Activity(
    name: 'Pulizia cucina profonda',
    subtasks: [
      Subtask(name: 'Pezza in forno'),
      Subtask(name: 'Svuota cibi scaduti / muffiti'),
      Subtask(name: 'Pezza su ripiani frigo'),
      Subtask(name: 'Grattugia grana'),
      Subtask(name: 'Travasa olio'),
    ],
    frequency: ActivityFrequency.weekly,
  ),
  Activity(
    name: 'Svuotare carta',
    subtasks: [
      Subtask(name: 'Svuota carta'),
    ],
    frequency: ActivityFrequency.weekly,
  ),
  Activity(
    name: 'Svuotare plastica',
    subtasks: [
      Subtask(name: 'Svuota plastica'),
    ],
    frequency: ActivityFrequency.weekly,
  ),
  Activity(
    name: 'Svuotare organico',
    subtasks: [
      Subtask(name: 'Svuota organico'),
    ],
    frequency: ActivityFrequency.weekly,
  ),
  Activity(
    name: 'Scopa',
    subtasks: [
      Subtask(name: 'Cucina pavimento'),
      Subtask(name: 'Cucina sedie'),
      Subtask(name: 'Corridoio'),
      Subtask(name: 'Bagno'),
      Subtask(name: 'Bagno sotto il lavabo'),
      Subtask(name: 'Camera', user: 'Francesco'),
    ],
    frequency: ActivityFrequency.weekly,
  ),
  Activity(
    name: 'Mocio',
    subtasks: [
      Subtask(name: 'Scopa Cucina pavimento'),
      Subtask(name: 'Scopa Cucina sedie'),
      Subtask(name: 'Scopa Corridoio'),
      Subtask(name: 'Scopa Bagno'),
      Subtask(name: 'Scopa Bagno sotto il lavabo'),
      Subtask(name: 'Scopa Camera', user: 'Francesco'),
      Subtask(name: 'Cucina pavimento'),
      Subtask(name: 'Corridoio'),
      Subtask(name: 'Bagno'),
      Subtask(name: 'Bagno sotto il lavabo'),
      Subtask(name: 'Camera', user: 'Francesco'),
      Subtask(name: 'Svuota mocio'),
    ],
    frequency: ActivityFrequency.weekly,
  ),
];
