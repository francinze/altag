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
        leading: IconButton(
            onPressed: () async {
              if (taskData['done'] == true) return;
              final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                          title: const Text('Skip activity?'),
                          content: const Text(
                              'Are you sure you want to skip this activity?'),
                          actions: [
                            TextButton(
                              child: const Text('Cancel'),
                              onPressed: () => Navigator.pop(context, false),
                            ),
                            TextButton(
                              child: const Text('Skip'),
                              onPressed: () => Navigator.pop(context, true),
                            ),
                          ]));
              if (confirm != true) return;
              await taskDoc.reference.update({'done': true});
              if (context.mounted) {
                taskData['done'] = true;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Activity skipped!')),
                );
              }
            },
            icon: Icon(
              Icons.block,
              color: taskData['done'] == true ? Colors.grey : Colors.red,
            )),
        contentPadding: const EdgeInsets.all(16),
        title: Text(taskData['name'] ?? ""),
        subtitle: Text("${taskData['day']} • ${taskData['timeslot']}"),
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
