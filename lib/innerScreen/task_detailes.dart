import 'package:company_app/constance/constante.dart';
import 'package:flutter/material.dart';

import '../widgets/comment_widget.dart';

class TaskDetailesScreen extends StatefulWidget {
  const TaskDetailesScreen({super.key});

  @override
  State<TaskDetailesScreen> createState() => _TaskDetailesScreenState();
}

bool _iscommenting = false;

class _TaskDetailesScreenState extends State<TaskDetailesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          title: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Back',
                style: TextStyle(color: Constance.normall, fontSize: 20),
              ))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Text('Task Detailes',
                  style: TextStyle(
                      color: Constance.normall,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('Uploaded By',
                              style: TextStyle(
                                  color: Constance.normall,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          const Spacer(),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 3, color: Colors.pink.shade800),
                                shape: BoxShape.circle,
                                image: const DecorationImage(
                                    image: NetworkImage(
                                        'https://i.imgur.com/JdfM8uX.png'))),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('uploaded Author name',
                                  style: TextStyle(
                                      color: Constance.normall,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                              Text('Author Posation',
                                  style: TextStyle(
                                      color: Constance.normall,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Divider(
                        thickness: 1,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Start On:',
                              style: TextStyle(
                                  color: Constance.normall,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          Text('20-10-2023',
                              style: TextStyle(
                                  color: Constance.normall,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Dead Line:',
                              style: TextStyle(
                                  color: Constance.normall,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          Text('21-10-2023',
                              style: TextStyle(
                                  color: Constance.normall,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text('Still Have Time',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      const Divider(
                        thickness: 1,
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Done State',
                            style: TextStyle(
                                color: Constance.normall,
                                fontSize: 25,
                                fontWeight: FontWeight.bold)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text('Done',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Constance.normall,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              const Opacity(
                                opacity: 0,
                                child: Icon(
                                  Icons.check_box,
                                  color: Colors.green,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text('Not Yet',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Constance.normall,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              const Opacity(
                                opacity: 0,
                                child: Icon(
                                  Icons.check_box,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Divider(
                        thickness: 1,
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Task Description',
                            style: TextStyle(
                                color: Constance.normall,
                                fontSize: 25,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text('Task Descrition',
                            style: TextStyle(
                                color: Constance.normall,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 10),
                      const Divider(
                        thickness: 1,
                      ),
                      const SizedBox(height: 10),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: _iscommenting
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 3,
                                    child: TextField(
                                        maxLength: 2000,
                                        maxLines: 6,
                                        // controller: ,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            enabledBorder:
                                                const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.red)),
                                            errorBorder:
                                                const UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.red)),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.pink)))),
                                  ),
                                  Flexible(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          MaterialButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            color: Colors.pink.shade400,
                                            onPressed: () {},
                                            child: const Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 14),
                                                  child: Text('Post',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  _iscommenting =
                                                      !_iscommenting;
                                                });
                                              },
                                              child: Text('Cancel',
                                                  style: TextStyle(
                                                      color: Constance.normall,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold)))
                                        ],
                                      ))
                                ],
                              )
                            : MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                color: Colors.pink.shade400,
                                onPressed: () {
                                  setState(() {
                                    _iscommenting = !_iscommenting;
                                  });
                                },
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 14),
                                      child: Text('Add Post',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (ctx, index) {
                            return CommentWidget();
                          },
                          separatorBuilder: (ctx, index) {
                            return const Divider(
                              thickness: 1,
                            );
                          },
                          itemCount: 20)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
