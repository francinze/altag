import 'package:altag/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

Future<void> signUpResident(String email, String password) async {
  final credential = await auth.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );

  await FirestoreService().addUser(credential.user!);
}

Future<void> loginUser(String email, String password) async {
  try {
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}

class UnauthenticatedPage extends StatelessWidget {
  const UnauthenticatedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Log in"),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              // obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await loginUser(emailController.text, passwordController.text);
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
