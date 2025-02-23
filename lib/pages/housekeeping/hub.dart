import 'package:altag/pages/housekeeping/metrics.dart';
import 'package:altag/pages/housekeeping/plan.dart';
import 'package:altag/pages/housekeeping/utils.dart';
import 'package:altag/pages/unauth.dart';
import 'package:altag/providers/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth.dart';
import '../../widgets/activity_tile.dart';

List<DocumentSnapshot> sortActivities(List<DocumentSnapshot> activities) {
  activities.sort((a, b) {
    final dataA = a.data() as Map<String, dynamic>;
    final dataB = b.data() as Map<String, dynamic>;

    final dayIndexA = days.indexOf(dataA['day'] ?? '');
    final dayIndexB = days.indexOf(dataB['day'] ?? '');

    // First, sort by day
    if (dayIndexA != dayIndexB) {
      return dayIndexA.compareTo(dayIndexB);
    }

    // If same day, sort by time slot priority
    final timePriorityA = timeslots.indexOf(dataA['timeslot'] ?? '');
    final timePriorityB = timeslots.indexOf(dataB['timeslot'] ?? '');

    return timePriorityA.compareTo(timePriorityB);
  });

  return activities;
}

class HousekeepingHubPage extends StatelessWidget {
  const HousekeepingHubPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<HouseAuthProvider>(context);
    final firestore = Provider.of<FirestoreService>(context);
    final currentUserName = authProvider.userName;

    final currentMonday = getCurrentWeekMonday();
    final currentWeekDocId = getWeekDocId(currentMonday);
    final nextMonday = getNextWeekMonday();
    final nextWeekDocId = getWeekDocId(nextMonday);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Housekeeping Hub"),
          centerTitle: true,
          actions: [
            if (currentUserName != null)
              IconButton(
                icon: const Icon(Icons.bar_chart),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HouseKeepingMetricsPage())),
              ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: "This Week"),
              Tab(text: "Next Week"),
            ],
          ),
        ),
        body: (currentUserName == null)
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Please log in to view your schedule."),
                    TextButton(
                      child: const Text("Log in"),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const UnauthenticatedPage())),
                    )
                  ],
                ),
              )
            : TabBarView(
                children: [
                  _buildTaskList(
                      "Current Week Tasks",
                      firestore.getTasksForWeek(
                          currentWeekDocId, currentUserName)),
                  _buildTaskList(
                      "Next Week Tasks",
                      firestore.getTasksForWeek(
                          nextWeekDocId, currentUserName)),
                ],
              ),
        floatingActionButton: (currentUserName == null)
            ? null
            : FloatingActionButton.extended(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PlanActivitiesPage())),
                icon: const Icon(Icons.edit_calendar),
                label: const Text("Plan Activities"),
              ),
      ),
    );
  }
}

Widget _buildTaskList(
        String title, Stream<List<DocumentSnapshot>> taskStream) =>
    Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            StreamBuilder<List<DocumentSnapshot>>(
              stream: taskStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                final tasks = snapshot.data!;
                final pastTasks = tasks
                    .where((task) =>
                        days.indexOf(task['day']) < DateTime.now().weekday - 1)
                    .toList();
                final currentTasks = tasks
                    .where((task) =>
                        days.indexOf(task['day']) >= DateTime.now().weekday - 1)
                    .toList();

                if (tasks.isEmpty) {
                  return const Padding(
                      padding: EdgeInsets.all(8.0), child: Text("No tasks."));
                }

                final sortedCurrentTasks = sortActivities(currentTasks);
                final sortedPastTasks = sortActivities(pastTasks);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Column(
                      children: sortedCurrentTasks
                          .map((d) => ActivityTile(
                                taskDoc: d,
                                taskData: d.data() as Map<String, dynamic>,
                              ))
                          .toList(),
                    ),
                    if (sortedPastTasks.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      const Text("Past Tasks",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      Column(
                        children: sortedPastTasks
                            .map((d) => ActivityTile(
                                  taskDoc: d,
                                  taskData: d.data() as Map<String, dynamic>,
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
