import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_to_doo/view/main_screen/task_screen.dart';

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
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('todo')
              .orderBy('time', descending: true)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              var todoItems = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: todoItems.length,
                  itemBuilder: (_, index) {
                    return InkWell(
                      onTap: () {
                        print(FirebaseFirestore.instance.collection('todo').doc());
                        Get.to(
                          () => TaskScreen(
                            title: todoItems[index]['title'],
                            description: todoItems[index]['description'],
                            time: todoItems[index]['time'].toDate(),
                            subtask: todoItems[index]['subtask'],
                            index:index,
                          ),
                        );
                      },
                      child: ToDoCard(
                        isDone: todoItems[index]['isdone'],
                        title: todoItems[index]['title'],
                        description: todoItems[index]['description'],
                        time: todoItems[index]['time'].toDate(),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
