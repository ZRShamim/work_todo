import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_to_doo/view/main_screen/add_todo_screen.dart';
import 'pending_todo_list.dart';
import 'widgets/todo_card.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Work',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
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
              Icons.logout_outlined,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => AddToDO());
                },
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.all(10),
                  width: screenWidth * 0.95,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Create New Task'),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Pending'),
                  TextButton(
                    onPressed: () {
                      Get.to(() => const PendingToDoList(isDone: false));
                    },
                    child: const Text(
                      'See All',
                    ),
                  ),
                ],
              ),
              Column(
                children: List.generate(3, (index) {
                  return const ToDoCard(isDone: false);
                }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Done'),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'See All',
                    ),
                  ),
                ],
              ),
              Column(
                children: List.generate(3, (index) {
                  return const ToDoCard(isDone: true);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
