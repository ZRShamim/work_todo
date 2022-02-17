import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/todo_card.dart';

class PendingToDoList extends StatelessWidget {
  const PendingToDoList({
    required this.isDone,
    Key? key,
  }) : super(key: key);

  final bool isDone;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pending Work',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 18,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, i) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ToDoCard(isDone: false,),
            );
          }),
    );
  }
}


