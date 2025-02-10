import 'package:altag/pages/housekeeping/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../const/activities.dart';
import '../../models/activity.dart';

class PlanActivitiesPage extends StatefulWidget {
  const PlanActivitiesPage({super.key});

  @override
  State<PlanActivitiesPage> createState() => PlanActivitiesPageState();
}

class PlanActivitiesPageState extends State<PlanActivitiesPage> {
  bool _isThisWeek = true;
  Activity? _selectedActivity;
  String _selectedDay = 'Monday';
  String _selectedTimeSlot = 'morning';
  String? _selectedUser;

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
    for (final user in users) {
      for (final day in daysOfWeek) {
        final pranzoSubtasks = activities['post_pranzo']!
            .subtasks
            .map((subtask) => subtask.toJson())
            .toList();
        for (var subtask in pranzoSubtasks) {
          subtask['done'] = false;
        }
        final pranzoAddSubtasks = activities['post_pranzo']!
            .additionalSubtasks!
            .map((subtask) => subtask.toJson())
            .toList();
        for (var subtask in pranzoAddSubtasks) {
          subtask['done'] = false;
        }
        final pranzoActivity = activities['post_pranzo']!.toJson();
        pranzoActivity['assignedTo'] = user;
        pranzoActivity['subtasks'] = pranzoSubtasks;
        pranzoActivity['additionalSubtasks'] = pranzoAddSubtasks;
        pranzoActivity['day'] = day;
        pranzoActivity['description'] =
            'Mansioni standard di pulizia post pasto.';
        pranzoActivity['timeslot'] = 'afternoon';
        pranzoActivity['done'] = false;
        pranzoActivity['createdAt'] = FieldValue.serverTimestamp();
        await fixedTasksRef.add(pranzoActivity);
        final cenaSubtasks = activities['post_cena']!
            .subtasks
            .map((subtask) => subtask.toJson())
            .toList();
        for (var subtask in cenaSubtasks) {
          subtask['done'] = false;
        }
        final cenaAddSubtasks = activities['post_cena']!
            .additionalSubtasks!
            .map((subtask) => subtask.toJson())
            .toList();
        for (var subtask in cenaAddSubtasks) {
          subtask['done'] = false;
        }
        final cenaActivity = activities['post_cena']!.toJson();
        cenaActivity['assignedTo'] = user;
        cenaActivity['subtasks'] = cenaSubtasks;
        cenaActivity['additionalSubtasks'] = cenaAddSubtasks;
        cenaActivity['day'] = day;
        cenaActivity['description'] =
            'Mansioni standard di pulizia post pasto.';
        cenaActivity['timeslot'] = 'evening';
        cenaActivity['done'] = false;
        cenaActivity['createdAt'] = FieldValue.serverTimestamp();
        await fixedTasksRef.add(cenaActivity);
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

    final monday = _isThisWeek ? getCurrentWeekMonday() : getNextWeekMonday();
    final weekDocId = getWeekDocId(monday);
    final firestore = FirebaseFirestore.instance;
    final fixedTasksRef = firestore
        .collection('housekeepingSchedules')
        .doc(weekDocId)
        .collection('chores');

    // Check if meal activities already exist
    final mealTasksQuery =
        await fixedTasksRef.where('frequency', isEqualTo: 0).get();

    final users = await firestore
        .collection('users')
        .get()
        .then((snapshot) => snapshot.docs.map((doc) => doc.id).toList());
    if (mealTasksQuery.docs.isEmpty) {
      await _generateMealActivities(fixedTasksRef, users);
    }

    // Now, create the selected task for the next week
    await fixedTasksRef.add({
      'name': _selectedActivity!.name,
      'description': _selectedActivity!.name,
      'day': _selectedDay,
      'timeslot': _selectedTimeSlot,
      'assignedTo': _selectedUser,
      'done': false,
      'subtasks': _selectedActivity!.subtasks
          .map((subtask) => {'name': subtask.name, 'done': false})
          .toList(),
      'additionalSubtasks': _selectedActivity!.additionalSubtasks
          ?.map((subtask) => {'name': subtask.name, 'done': false})
          .toList(),
      'frequency':
          ActivityFrequency.values.indexOf(_selectedActivity!.frequency),
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
            DropdownButtonFormField<bool>(
              decoration: const InputDecoration(
                labelText: "Week: ",
                border: OutlineInputBorder(),
              ),
              value: _isThisWeek,
              items: const [
                DropdownMenuItem<bool>(
                  value: true,
                  child: Text("This Week"),
                ),
                DropdownMenuItem<bool>(
                  value: false,
                  child: Text("Next Week"),
                ),
              ],
              onChanged: (value) => setState(() => _isThisWeek = value!),
            ),
            const SizedBox(height: 16),
            // Dropdown to select an activity.
            DropdownButtonFormField<Activity>(
              decoration: const InputDecoration(
                labelText: "Select Activity",
                border: OutlineInputBorder(),
              ),
              value: _selectedActivity,
              items: activities.values
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
              items: days
                  .map((day) => DropdownMenuItem<String>(
                        value: day,
                        child: Text(day),
                      ))
                  .toList(),
              onChanged: (String? value) =>
                  setState(() => _selectedDay = value!),
            ),
            const SizedBox(height: 16),
            // Dropdown for selecting a timeslot.
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "Select Time Slot",
                border: OutlineInputBorder(),
              ),
              value: _selectedTimeSlot,
              items: timeslots
                  .map((slot) => DropdownMenuItem<String>(
                        value: slot,
                        child: Text(slot),
                      ))
                  .toList(),
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
