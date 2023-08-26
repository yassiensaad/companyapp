import 'package:flutter/material.dart';

class AllWorkerWidget extends StatefulWidget {
  const AllWorkerWidget({super.key});

  @override
  State<AllWorkerWidget> createState() => _AllWorkerWidgetState();
}

class _AllWorkerWidgetState extends State<AllWorkerWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ListTile(
        onTap: () {},
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
            backgroundColor: Colors.transparent,
            radius: 20,
            child: Image.network('https://i.imgur.com/JdfM8uX.png'),
          ),
        ),
        title: const Text(
          'Name',
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
                'Position in company/01244578966',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16),
              )
            ]),
        trailing: Icon(
          Icons.mail,
          color: Colors.pink[800],
          size: 30,
        ),
      ),
    );
  }
}
