import 'package:company_app/innerScreen/task_detailes.dart';
import 'package:flutter/material.dart';

class TaskWidgets extends StatefulWidget {
  const TaskWidgets({super.key});

  @override
  State<TaskWidgets> createState() => _TaskWidgetsState();
}

class _TaskWidgetsState extends State<TaskWidgets> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const TaskDetailesScreen()));
        },
        onLongPress: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  actions: [
                    TextButton(
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.delete,
                                color: Colors.pink[400],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Delete',
                                style: TextStyle(
                                    color: Colors.pink[400], fontSize: 16),
                              )
                            ],
                          ),
                        ))
                  ],
                );
              });
        },
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        leading: Container(
          padding: const EdgeInsets.only(right: 20.0),
          decoration: const BoxDecoration(
              border: Border(right: BorderSide(width: 1.0))),
          child: CircleAvatar(
            radius: 20,
            child: Image.network('https://i.imgur.com/Owg9qFE.png'),
          ),
        ),
        title: const Text(
          'title',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.linear_scale,
                color: Colors.pink,
              ),
              Text(
                'Subtitle/describtion',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16),
              )
            ]),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.pink[800],
          size: 30,
        ),
      ),
    );
  }
}
