import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WhiteboardPage extends StatefulWidget {
  const WhiteboardPage({super.key});

  @override
  WhiteboardPageState createState() => WhiteboardPageState();
}

class WhiteboardPageState extends State<WhiteboardPage> {
  final TextEditingController _controller = TextEditingController();
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref('whiteboard');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.whiteboard_title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: null,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.write_your_note,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final note = _controller.text.trim();
                if (note.isNotEmpty) {
                  await _dbRef.push().set({'note': note});
                  _controller.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Note saved!')),
                  );
                }
              },
              child: const Text('Save Note'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<DatabaseEvent>(
                stream: _dbRef.onValue,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData ||
                      snapshot.data?.snapshot.value == null) {
                    return const Center(child: Text('No notes yet!'));
                  }
                  final Map<dynamic, dynamic> notes =
                      (snapshot.data!.snapshot.value as Map<dynamic, dynamic>);
                  return ListView(
                    children: notes.entries.map((entry) {
                      return ListTile(
                        title: Text(entry.value['note']),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _dbRef.child(entry.key).remove(),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
