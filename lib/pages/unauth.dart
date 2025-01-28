import 'package:altag/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../generated/l10n.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

Future<void> loginUser(String userName) async {
  try {
    await FirestoreService.checkUser(userName);
    FirebaseAuth.instance.signInAnonymously();
  } on FirebaseAuthException catch (_) {
    rethrow;
  }
}

class UnauthenticatedPage extends StatelessWidget {
  const UnauthenticatedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userNameController = TextEditingController();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Log in"),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: userNameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                try {
                  await loginUser(userNameController.text);
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    print(S.of(context).authUserNotFound);
                  }
                }
                await loginUser(userNameController.text);
                Navigator.pop(context);
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
