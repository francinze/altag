import 'package:altag/pages/housekeeping/activity.dart';
import 'package:altag/pages/housekeeping/plan.dart';
import 'package:altag/pages/unauth.dart';
import 'package:altag/providers/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth.dart';
import '../../widgets/activity_tile.dart';

// Helper functions to compute the week document IDs, assuming Monday is the starting day.
DateTime getCurrentWeekMonday() {
  final now = DateTime.now();
  // In Dart, Monday is weekday 1.
  final int daysSinceMonday = now.weekday - 1;
  return DateTime(now.year, now.month, now.day)
      .subtract(Duration(days: daysSinceMonday));
}

DateTime getNextWeekMonday() {
  final currentMonday = getCurrentWeekMonday();
  return currentMonday.add(const Duration(days: 7));
}

String getWeekDocId(DateTime monday) {
  return "${monday.year}-${monday.month.toString().padLeft(2, '0')}-${monday.day.toString().padLeft(2, '0')}";
}

int getDayIndex(String day) {
  const daysOrder = {
    'Monday': 0,
    'Tuesday': 1,
    'Wednesday': 2,
    'Thursday': 3,
    'Friday': 4,
    'Saturday': 5,
    'Sunday': 6,
  };
  return daysOrder[day] ?? 7; // Default to the end if invalid
}

int getTimeSlotPriority(String timeSlot) {
  const timeOrder = {
    'morning': 0,
    'afternoon': 1,
    'evening': 2,
  };
  return timeOrder[timeSlot] ?? 5; // Default to the end if invalid
}

final List<String> _days = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday'
];

List<DocumentSnapshot> sortActivities(List<DocumentSnapshot> activities) {
  activities.sort((a, b) {
    final dataA = a.data() as Map<String, dynamic>;
    final dataB = b.data() as Map<String, dynamic>;

    final dayIndexA = getDayIndex(dataA['day'] ?? '');
    final dayIndexB = getDayIndex(dataB['day'] ?? '');

    // First, sort by day
    if (dayIndexA != dayIndexB) {
      return dayIndexA.compareTo(dayIndexB);
    }

    // If same day, sort by time slot priority
    final timeSlotA = dataA['timeSlot'] ?? '';
    final timeSlotB = dataB['timeSlot'] ?? '';
    final timePriorityA = getTimeSlotPriority(timeSlotA);
    final timePriorityB = getTimeSlotPriority(timeSlotB);

    return timePriorityA.compareTo(timePriorityB);
  });

  return activities;
}

class HousekeepingHubPage extends StatelessWidget {
  const HousekeepingHubPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the authenticated user from the provider.
    final authProvider = Provider.of<HouseAuthProvider>(context);
    final firestore = Provider.of<FirestoreService>(context);
    final currentUserName = authProvider.userName;

    // If the user is not logged in, show a prompt.
    if (currentUserName == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Housekeeping Hub")),
        body: Center(
          child: Column(
            children: [
              const Text("Please log in to view your schedule."),
              TextButton(
                child: const Text("Log in"),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UnauthenticatedPage())),
              )
            ],
          ),
        ),
      );
    }

    // Calculate the document IDs for the current and next weeks.
    final currentMonday = getCurrentWeekMonday();
    final currentWeekDocId = getWeekDocId(currentMonday);
    final nextMonday = getNextWeekMonday();
    final nextWeekDocId = getWeekDocId(nextMonday);

    return Scaffold(
      appBar: AppBar(title: const Text("Housekeeping Hub")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTaskList("Current Week Tasks",
                firestore.getTasksForWeek(currentWeekDocId, currentUserName)),
            const SizedBox(height: 32),
            _buildTaskList("Next Week Tasks",
                firestore.getTasksForWeek(nextWeekDocId, currentUserName)),
          ],
        ),
      ),
      // Optional: FAB for planning next week's tasks.
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const PlanNextWeekPage();
        })),
        icon: const Icon(Icons.edit_calendar),
        label: const Text("Plan Next Week"),
      ),
    );
  }
}

/// Builds a widget that displays a list of tasks, with a title and a stream of
/// tasks. If the stream is empty, displays a message "No tasks.".
///
/// The tasks are displayed as a list of cards, with the title of the task as the
/// title of the card, and the day and time slot as the subtitle. If the task is
/// done, displays a green checkmark; otherwise, displays a radio button.
///
/// When a task is tapped, navigates to the [ActivityDetailsPage] with the
/// task's reference and data.
///
/// The [title] parameter is the title of the list of tasks, displayed as a
/// headline.
///
/// The [taskStream] parameter is the stream of tasks.
Widget _buildTaskList(String title, Stream<List<DocumentSnapshot>> taskStream) {
  return Center(
    child: Column(
      children: [
        Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        StreamBuilder<List<DocumentSnapshot>>(
          stream: taskStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();
            final tasks = snapshot.data!;
            if (tasks.isEmpty) {
              return const Padding(
                  padding: EdgeInsets.all(8.0), child: Text("No tasks."));
            }
            tasks.removeWhere((task) =>
                _days.indexOf(task['day']) < DateTime.now().weekday - 1 &&
                title == "Current Week Tasks");
            final sortedTasks = sortActivities(tasks);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: sortedTasks.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) => ActivityTile(
                    taskDoc: sortedTasks[index],
                    taskData: sortedTasks[index].data() as Map<String, dynamic>,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    ),
  );
}
