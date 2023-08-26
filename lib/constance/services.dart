import 'package:flutter/material.dart';

mixin globalServices {
  static void errorOccourd(
      {required String error, required BuildContext context}) {
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
              content: Text(
                error,
                style: const TextStyle(fontSize: 20),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(fontSize: 20, color: Colors.red),
                    ))
              ]);
        });
  }
}
