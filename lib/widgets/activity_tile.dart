import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../pages/housekeeping/activity.dart';

class ActivityTile extends StatelessWidget {
  const ActivityTile(
      {super.key, required this.taskDoc, required this.taskData});
  final DocumentSnapshot taskDoc;
  final Map<String, dynamic> taskData;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: taskData['done'] == true
          ? Colors.green[50]
          : Theme.of(context).colorScheme.surface,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(taskData['title'] ?? ""),
        subtitle: Text("${taskData['day']} • ${taskData['timeSlot']}"),
        trailing: taskData['done'] == true
            ? const Icon(Icons.check_circle, color: Colors.green)
            : Icon(Icons.radio_button_unchecked,
                color: Theme.of(context).colorScheme.primary),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ActivityDetailsPage(
              taskRef: taskDoc.reference,
              taskData: taskData,
            ),
          ),
        ),
      ),
    );
  }
}
