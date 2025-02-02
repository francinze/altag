import 'package:altag/providers/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../generated/l10n.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class UnauthenticatedPage extends StatelessWidget {
  const UnauthenticatedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userNameController = TextEditingController();
    final auth = Provider.of<HouseAuthProvider>(context);
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
                  await auth.signInWithUsername(userNameController.text);
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(S.of(context).authUserNotFound)),
                      );
                    }
                  }
                }
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
