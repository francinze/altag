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
  bool doingAdditionals = false;
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
      doingAdditionals = additionalSubtasks!.any((sub) => sub['done']);
    } else {
      additionalSubtasks = null;
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

  /// Toggle a subtask's done state and update Firestore.
  Future<void> toggleAllAdditionalSubtasks() async =>
      setState(() => doingAdditionals = !doingAdditionals);

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(widget.taskData['description'] ?? ""),
              const SizedBox(height: 16),
              ...subtasks.map((subtask) => CheckboxListTile(
                    title: Text(subtask['name']),
                    value: subtask['done'],
                    onChanged: (bool? _) =>
                        toggleSubtask(subtasks.indexOf(subtask)),
                  )),
              if (additionalSubtasks != null) ...[
                const SizedBox(height: 16),
                CheckboxListTile(
                  value: doingAdditionals,
                  onChanged: (_) => toggleAllAdditionalSubtasks(),
                  title: Text(
                      widget.taskData['name']!.startsWith('Pulizia post')
                          ? "Stai mangiando per ultimo?"
                          : ""),
                ),
                if (doingAdditionals ||
                    additionalSubtasks!.any((sub) => sub['done']))
                  ...additionalSubtasks!.map((subtask) => CheckboxListTile(
                        title: Text(subtask['name']),
                        value: subtask['done'],
                        onChanged: (bool? _) => toggleAdditionalSubtask(
                          additionalSubtasks!.indexOf(subtask),
                        ),
                      )),
              ],
              ElevatedButton(
                onPressed: () async {
                  await widget.taskRef.update({'status': 'done'});
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Activity marked as done!')),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text("Mark Activity as Done"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
