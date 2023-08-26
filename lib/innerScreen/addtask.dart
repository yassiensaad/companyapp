import 'package:company_app/constance/constante.dart';
import 'package:flutter/material.dart';

import '../widgets/drawe_widget.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _categoriesController =
      TextEditingController(text: 'Task Categories');
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _deadlineDateController =
      TextEditingController(text: 'Pick up date');
  final _loginKey = GlobalKey<FormState>();
  DateTime? picked;

  @override
  void dispose() {
    super.dispose();
    _categoriesController.dispose();
    _deadlineDateController.dispose();
    _descriptionController.dispose();
    _titleController.dispose();
  }

  void onsubmetform() {
    final isvaild = _loginKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isvaild) {
      // ignore: avoid_print
      print('pressed');
    } else {
      // ignore: avoid_print
      print('un pressed');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        drawer: const DrawerWidget(),
        body: Padding(
          padding:
              const EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 50),
          child: SingleChildScrollView(
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'All Fields is Required',
                      style: TextStyle(
                        color: Constance.normall,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Form(
                      key: _loginKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _textForm(labelForm: 'Task Categories'),
                          _taskForm(
                              enabled: false,
                              fct: () {
                                _showFilterDialoge(size);
                              },
                              length: 100,
                              valueKey: 'TaskCategory',
                              controller: _categoriesController),
                          _textForm(labelForm: 'Task Title'),
                          _taskForm(
                              enabled: true,
                              fct: () {},
                              length: 100,
                              valueKey: 'Tasktitle',
                              controller: _titleController),
                          _textForm(labelForm: 'Task Description'),
                          _taskForm(
                              enabled: true,
                              fct: () {},
                              length: 1000,
                              valueKey: 'taskDiscription',
                              controller: _descriptionController),
                          _textForm(labelForm: 'Task deadline date'),
                          _taskForm(
                              enabled: false,
                              fct: () {
                                _pickeddate();
                              },
                              length: 100,
                              valueKey: 'taskDeadline Date',
                              controller: _deadlineDateController),
                        ],
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: Colors.pink.shade400,
                      onPressed: onsubmetform,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            child: Text('Upload',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.login,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void _pickeddate() async {
    picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(const Duration(days: 0)),
        lastDate: DateTime(3000));
    if (picked != null) {
      setState(() {
        _deadlineDateController.text =
            '${picked!.year}-${picked!.month}-${picked!.day}';
      });
    }
  }

  Widget _taskForm({
    required Function fct,
    required TextEditingController controller,
    required String valueKey,
    required int length,
    required bool enabled,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          fct();
        },
        child: TextFormField(
          controller: controller,
          validator: (value) {
            if (value!.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
          enabled: enabled,
          key: ValueKey(valueKey),
          style: TextStyle(color: Constance.normall),
          maxLines: valueKey == 'taskDiscription' ? 3 : 1,
          maxLength: length,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).scaffoldBackgroundColor,
              errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red)),
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.pink))),
        ),
      ),
    );
  }

  _showFilterDialoge(size) {
    return showDialog(
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
                        setState(() {
                          _categoriesController.text =
                              Constance.taskCategories[index];
                        });
                        Navigator.pop(context);
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
                                fontSize: 18, color: Colors.blue[500]),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                  },
                  child: const Text(
                    'close',
                    style: TextStyle(fontSize: 20, color: Colors.pink),
                  )),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Cancel Filters',
                    style: TextStyle(fontSize: 20, color: Colors.pink),
                  ))
            ],
          );
        });
  }

  Widget _textForm({required String labelForm}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(labelForm,
          style: TextStyle(
            color: Colors.pink[800],
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          )),
    );
  }
}
