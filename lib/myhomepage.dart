import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authprovider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userData = FirebaseAuth.instance.currentUser!;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Social login with firebase"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 40,
              backgroundImage: NetworkImage(userData.photoURL!),
            ),
            const SizedBox(height: 10),
            Text(userData.displayName!),
            const SizedBox(height: 5),
            Text(userData.email!),
            const SizedBox(height: 30),
            if (userData.phoneNumber != null) Text(userData.phoneNumber!),
            const SizedBox(height: 30),
            TextButton(
                onPressed: authProvider.googleLogout,
                child: const Text("Logout"))
          ],
        ),
      ),
    );
  }
}
