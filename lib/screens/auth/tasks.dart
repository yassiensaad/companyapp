import 'package:company_app/constance/constante.dart';
import 'package:company_app/widgets/taskwidgets.dart';
import 'package:flutter/material.dart';

import '../../widgets/drawe_widget.dart';

class Tasks extends StatelessWidget {
  const Tasks({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        leading: Builder(builder: (ctx) {
          return IconButton(
              onPressed: () {
                Scaffold.of(ctx).openDrawer();
              },
              icon: Icon(
                Icons.menu_open_sharp,
                color: Colors.pink[400],
              ));
        }),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text('tasks'),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                          'Tasks Categories',
                          style: TextStyle(
                              color: Colors.pink,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        content: SizedBox(
                          width: size.width * 0.9,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: Constance.taskCategories.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    // ignore: avoid_print
                                    print(
                                        'you choose ${Constance.taskCategories[index]}');
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.check_circle,
                                        color: Colors.pink,
                                        size: 15,
                                      ),
                                      Text(
                                        Constance.taskCategories[index],
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.blue[500]),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.canPop(context)
                                    ? Navigator.pop(context)
                                    : null;
                              },
                              child: const Text(
                                'close',
                                style:
                                    TextStyle(fontSize: 20, color: Colors.pink),
                              )),
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Cancel Filters',
                                style:
                                    TextStyle(fontSize: 20, color: Colors.pink),
                              ))
                        ],
                      );
                    });
              },
              icon: const Icon(Icons.filter_alt_rounded))
        ],
      ),
      body: ListView.builder(itemBuilder: (BuildContext context, int index) {
        return const TaskWidgets();
      }),
    );
  }
}
