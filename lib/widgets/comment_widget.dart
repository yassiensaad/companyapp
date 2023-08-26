// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../constance/constante.dart';

class CommentWidget extends StatelessWidget {
  final List<Color> _colors = [
    Colors.orange,
    Colors.red,
    Colors.cyan,
    Colors.blue
  ];

  CommentWidget({super.key});
  @override
  Widget build(BuildContext context) {
    _colors.shuffle();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          width: 2,
        ),
        Flexible(
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                border: Border.all(width: 3, color: _colors[1]),
                shape: BoxShape.circle,
                image: const DecorationImage(
                    image: NetworkImage('https://i.imgur.com/JdfM8uX.png'))),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Commenter name',
                  style: TextStyle(
                      color: Constance.normall,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              Text('Comment Text',
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Constance.normall,
                      fontSize: 13,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        )
      ],
    );
  }
}
