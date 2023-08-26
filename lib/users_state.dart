import 'package:company_app/screens/auth/login.dart';
import 'package:company_app/screens/auth/tasks.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, usersnapshot) {
          if (usersnapshot.data == null) {
            print('user can\'t be access');
            return LoginScreen();
          } else if (usersnapshot.hasData) {
            print('user has been login before');
            return Tasks();
          } else if (usersnapshot.hasError) {
            return const Center(
              child: Text(
                'An Error occurding app work',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            );
          }
          return const Scaffold(
              body: Center(
            child: Text(
              'some thing went wrong',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ));
        });
  }
}
