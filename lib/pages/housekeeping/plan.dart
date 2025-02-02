import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../const/activities.dart';

class PlanNextWeekPage extends StatefulWidget {
  const PlanNextWeekPage({super.key});

  @override
  PlanNextWeekPageState createState() => PlanNextWeekPageState();
}

class PlanNextWeekPageState extends State<PlanNextWeekPage> {
  Activity? _selectedActivity;
  String _selectedDay = 'Monday';
  String _selectedTimeSlot = 'morning';
  String? _selectedUser;

  final List<String> _days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  final List<String> _timeslots = ['morning', 'afternoon', 'evening'];

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

  Future<void> _generateMealActivities(
      CollectionReference fixedTasksRef, List<String> users) async {
    final daysOfWeek = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    final mealTimes = ['Pranzo', 'Cena'];
    for (final user in users) {
      for (final day in daysOfWeek) {
        for (final meal in mealTimes) {
          final subtasks = activities
              .firstWhere((activity) => activity.name == 'Pulizia post pasto')
              .subtasks
              .map((subtask) => subtask.toJson())
              .toList();
          for (var subtask in subtasks) {
            subtask['done'] = false;
          }
          await fixedTasksRef.add({
            'title': 'Pulizia post $meal',
            'description': 'Mansioni standard di pulizia post $meal',
            'day': day,
            'timeSlot': meal == 'Pranzo' ? 'afternoon' : 'evening',
            'assignedTo': user,
            'done': false,
            'subtasks': subtasks,
            'createdAt': FieldValue.serverTimestamp(),
          });
        }
      }
    }
  }

  Future<void> _createTask() async {
    if (_selectedActivity == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select an activity.")),
      );
      return;
    }

    if (_selectedUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please select a user to assign the task.")),
      );
      return;
    }

    final nextMonday = getNextWeekMonday();
    final weekDocId = getWeekDocId(nextMonday);
    final firestore = FirebaseFirestore.instance;
    final fixedTasksRef = firestore
        .collection('housekeepingSchedules')
        .doc(weekDocId)
        .collection('chores');

    // Check if meal activities already exist
    final mealTasksQuery = await fixedTasksRef
        .where('title', isGreaterThanOrEqualTo: 'Meal Cleanup')
        .get();

    final users = await firestore
        .collection('users')
        .get()
        .then((snapshot) => snapshot.docs.map((doc) => doc.id).toList());
    if (mealTasksQuery.docs.isEmpty) {
      await _generateMealActivities(fixedTasksRef, users);
    }

    // Now, create the selected task for the next week
    await fixedTasksRef.add({
      'title': _selectedActivity!.name,
      'description': _selectedActivity!.name,
      'day': _selectedDay,
      'timeSlot': _selectedTimeSlot,
      'assignedTo': _selectedUser,
      'done': false,
      'subtasks': _selectedActivity!.subtasks
          .map((subtask) => {'name': subtask.name, 'done': false})
          .toList(),
      'createdAt': FieldValue.serverTimestamp(),
    });
    if (context.mounted && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Task created for next week.")),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Plan Next Week"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dropdown to select an activity.
            DropdownButtonFormField<Activity>(
              decoration: const InputDecoration(
                labelText: "Select Activity",
                border: OutlineInputBorder(),
              ),
              value: _selectedActivity,
              items: activities
                  .where((activity) =>
                      activity.frequency != ActivityFrequency.everyMeal)
                  .map((activity) {
                return DropdownMenuItem<Activity>(
                  value: activity,
                  child: Text(activity.name),
                );
              }).toList(),
              onChanged: (Activity? value) =>
                  setState(() => _selectedActivity = value),
            ),
            const SizedBox(height: 16),
            // Dropdown for selecting a day.
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "Select Day",
                border: OutlineInputBorder(),
              ),
              value: _selectedDay,
              items: _days.map((day) {
                return DropdownMenuItem<String>(
                  value: day,
                  child: Text(day),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _selectedDay = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            // Dropdown for selecting a timeslot.
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "Select Time Slot",
                border: OutlineInputBorder(),
              ),
              value: _selectedTimeSlot,
              items: _timeslots.map((slot) {
                return DropdownMenuItem<String>(
                  value: slot,
                  child: Text(slot),
                );
              }).toList(),
              onChanged: (String? value) =>
                  setState(() => _selectedTimeSlot = value!),
            ),
            const SizedBox(height: 16),
            // Dropdown for selecting a user (fetched from Firestore).
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('users').get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: "Assign to",
                    border: OutlineInputBorder(),
                  ),
                  value: _selectedUser,
                  items: snapshot.data!.docs
                      .map((doc) => DropdownMenuItem<String>(
                            value: doc.id,
                            child: Text(doc.id),
                          ))
                      .toList(),
                  onChanged: (value) => setState(() => _selectedUser = value),
                );
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _createTask,
              child: const Text("Create Task"),
            ),
          ],
        ),
      ),
    );
  }
}
