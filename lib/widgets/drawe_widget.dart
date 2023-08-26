import 'package:company_app/innerScreen/addtask.dart';
import 'package:company_app/screens/auth/allworkers.dart';
import 'package:company_app/screens/auth/tasks.dart';
import 'package:company_app/users_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constance/constante.dart';
import '../screens/auth/worker_account.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        DrawerHeader(
            decoration: const BoxDecoration(color: Colors.cyan),
            child: Column(
              children: [
                Flexible(
                    child: Image.network(
                  'https://i.imgur.com/Spk9BbS.png',
                )),
                const SizedBox(
                  height: 20,
                ),
                const Flexible(child: Text('Company App'))
              ],
            )),
        _listTile(
            lable: 'All Tasks',
            fct: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Tasks()));
            },
            icon: Icons.task),
        _listTile(
            lable: 'My Account',
            fct: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const WorkerAccountScreen()));
            },
            icon: Icons.settings),
        _listTile(
            lable: 'Registered Workers',
            fct: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const AllWorkers()));
            },
            icon: Icons.workspaces),
        _listTile(
            lable: 'Add Taskes',
            fct: () {
              _navigateToAddTaskScreen(context);
            },
            icon: Icons.add_task),
        const Divider(
          thickness: 1,
        ),
        _listTile(
            lable: 'Logout',
            fct: () {
              _logout(context);
            },
            icon: Icons.logout),
      ]),
    );
  }

  void _navigateToAddTaskScreen(context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AddTaskScreen()));
  }

  void _logout(context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Row(children: [
                Flexible(
                    child: CircleAvatar(
                        child:
                            Image.network('https://i.imgur.com/Spk9BbS.png'))),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Alert'),
                ),
              ]),
              content: const Text(
                'Do You Wanna LogOut?',
                style: TextStyle(fontSize: 20),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.canPop(context) ? Navigator.pop(context) : null;
                    },
                    child: const Text(
                      'No',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    )),
                TextButton(
                    onPressed: () async {
                      await _auth.signOut();
                      Navigator.canPop(context) ? Navigator.pop(context) : null;
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => UserState()));
                    },
                    child: const Text(
                      'Yes',
                      style: TextStyle(fontSize: 20, color: Colors.red),
                    ))
              ]);
        });
  }

  Widget _listTile(
      {required String lable, required Function fct, required IconData icon}) {
    return ListTile(
        onTap: () {
          fct();
        },
        leading: Icon(
          icon,
          color: Constance.normall,
        ),
        title: Text(
          lable,
          style: TextStyle(
              color: Constance.normall,
              fontSize: 20,
              fontStyle: FontStyle.italic),
        ));
  }
}
