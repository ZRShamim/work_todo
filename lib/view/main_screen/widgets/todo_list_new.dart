import 'package:flutter/material.dart';

import './todo_card.dart';

class ToDoListNew extends StatelessWidget {
  const ToDoListNew({
    required this.isDone,
    Key? key,
  }) : super(key: key);

  final bool isDone;

  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: List.generate(3, (index) {
        return ToDoCard(isDone: isDone);
      }),
    );
  }
}
