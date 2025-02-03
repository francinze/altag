final List<String> days = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday'
];
final List<String> timeslots = ['morning', 'afternoon', 'evening'];

/// Computes current week's Monday (assuming Monday is the starting day).
DateTime getCurrentWeekMonday() {
  final now = DateTime.now();
  // In Dart, Monday is weekday 1.
  final int daysSinceMonday = now.weekday - 1;
  return DateTime(now.year, now.month, now.day)
      .subtract(Duration(days: daysSinceMonday));
}

/// Computes next week's Monday (assuming Monday is the starting day).
DateTime getNextWeekMonday() {
  final now = DateTime.now();
  // In Dart, Monday is weekday 1.
  final int daysToSubtract = now.weekday - 1; // days since this week's Monday
  final currentMonday = DateTime(now.year, now.month, now.day)
      .subtract(Duration(days: daysToSubtract));
  final nextMonday = currentMonday.add(const Duration(days: 7));
  return DateTime(nextMonday.year, nextMonday.month, nextMonday.day);
}

/// Returns a document ID string based on the given date.
String getWeekDocId(DateTime monday) {
  return "${monday.year}-${monday.month.toString().padLeft(2, '0')}-${monday.day.toString().padLeft(2, '0')}";
}
