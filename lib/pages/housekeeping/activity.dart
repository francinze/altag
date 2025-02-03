import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../../providers/auth.dart';

class ActivityDetailsPage extends StatefulWidget {
  final DocumentReference taskRef;
  final Map<String, dynamic> taskData;

  const ActivityDetailsPage(
      {super.key, required this.taskRef, required this.taskData});

  @override
  ActivityDetailsPageState createState() => ActivityDetailsPageState();
}

class ActivityDetailsPageState extends State<ActivityDetailsPage> {
  late List<dynamic> subtasks;
  late List<dynamic>? additionalSubtasks;
  late String username;

  @override
  void initState() {
    super.initState();
    username = Provider.of<HouseAuthProvider>(context, listen: false).userName!;
    subtasks = List.from(widget.taskData['subtasks'] ?? [])
        .where((sub) =>
            sub['user'] == username ||
            sub['user'] == 'Everyone' ||
            sub['user'] == null)
        .toList();

    if (widget.taskData['additionalSubtasks'] != null) {
      additionalSubtasks =
          List.from(widget.taskData['additionalSubtasks'] ?? [])
              .where((sub) =>
                  sub['user'] == username ||
                  sub['user'] == 'Everyone' ||
                  sub['user'] == null)
              .toList();
    }
  }

  /// Toggle a subtask's done state and update Firestore.
  Future<void> toggleSubtask(int index) async {
    setState(
        () => subtasks[index]['done'] = !(subtasks[index]['done'] as bool));
    await widget.taskRef.update({'subtasks': subtasks});
  }

  /// Toggle a subtask's done state and update Firestore.
  Future<void> toggleAdditionalSubtask(int index) async {
    setState(() => additionalSubtasks![index]['done'] =
        !(additionalSubtasks![index]['done'] as bool));
    await widget.taskRef.update({'additionalSubtasks': additionalSubtasks});
  }

  /// Check if all subtasks are completed.
  bool allSubtasksDone() {
    return subtasks.every((sub) => sub['done'] == true) &&
        (additionalSubtasks == null ||
            additionalSubtasks!.every((sub) => sub['done'] == true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(widget.taskData['name'] ?? "Activity Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(widget.taskData['description'] ?? ""),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: subtasks.length,
                itemBuilder: (context, index) {
                  final subtask = subtasks[index];
                  return CheckboxListTile(
                    title: Text(subtask['name']),
                    value: subtask['done'],
                    onChanged: (bool? _) => toggleSubtask(index),
                  );
                },
              ),
            ),
            if (additionalSubtasks != null) ...[
              const SizedBox(height: 16),
              Text(widget.taskData['name']!.startsWith('Pulizia post')
                  ? "Se stai mangiando per ultimo:"
                  : ""),
              Expanded(
                child: ListView.builder(
                  itemCount: additionalSubtasks!.length,
                  itemBuilder: (context, index) {
                    final subtask = additionalSubtasks![index];
                    return CheckboxListTile(
                      title: Text(subtask['name']),
                      value: subtask['done'],
                      onChanged: (bool? _) => toggleAdditionalSubtask(index),
                    );
                  },
                ),
              ),
            ],
            ElevatedButton(
              onPressed: allSubtasksDone()
                  ? () async {
                      await widget.taskRef.update({'done': true});
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Activity marked as done!')),
                        );
                        Navigator.pop(context);
                      }
                    }
                  : null,
              child: const Text("Mark Activity as Done"),
            ),
          ],
        ),
      ),
    );
  }
}
