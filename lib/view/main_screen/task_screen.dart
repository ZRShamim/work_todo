import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({
    Key? key,
    required this.taskId,
    required this.title,
    required this.description,
    required this.time,
    required this.subtask,
    required this.userId,
    required this.isDone,
  }) : super(key: key);

  final String taskId;
  final String title;
  final String description;
  final DateTime time;
  final List subtask;
  final String userId;
  final bool isDone;

  void addSubTask(TextEditingController subTaskController, BuildContext ctx) {
      if (subTaskController.text.isNotEmpty) {
        subtask.add({"description": subTaskController.text, "isdone": false});
        subTaskController.clear();
        FocusScope.of(ctx).unfocus();

        FirebaseFirestore instance = FirebaseFirestore.instance;
        instance.collection('todo').doc(taskId).set({
          'id': taskId,
          'title': title,
          'description': description,
          'time': time,
          'userid': userId,
          'isdone': isDone,
          'subtask': subtask,
        });
      }
    }

    void updateSubTask(int index) {
      subtask[index]['isdone'] = !subtask[index]['isdone'];
      print(subtask[index]['isdone']);
    }

  @override
  Widget build(BuildContext context) {
    // var screenWidth = MediaQuery.of(context).size.width;

    final TextEditingController subTaskController = TextEditingController();

    // var screenHeight = MediaQuery.of(context).size.height;

    

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Task Details',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 18,
              color: Colors.black,
            )),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 5, top: 15),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    description,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    DateFormat('yyyy-MM-dd kk:mm').format(time),
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(6),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: TextFormField(
                  controller: subTaskController,
                  onEditingComplete: () => addSubTask(subTaskController, context),
                  decoration: const InputDecoration(
                    labelText: 'Enter Task',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextButton.icon(
                onPressed: () => addSubTask(subTaskController, context),
                icon: const Icon(
                  Icons.add,
                  color: Color.fromARGB(255, 76, 175, 158),
                ),
                label: const Text(
                  'Add Task',
                  style: TextStyle(color: Colors.black),
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: subtask.length,
              itemBuilder: (context, index) {
                return SubTask(
                  description: subtask[index]['description'],
                  isdone: subtask[index]['isdone'],
                  updateSubTask: () => updateSubTask(index),
                );
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          BottomButton(
            taskId: taskId,
          ),
        ],
      ),
    );
  }
}

class BottomButton extends StatelessWidget {
  const BottomButton({
    Key? key,
    required this.taskId,
  }) : super(key: key);

  final String taskId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Container(
            padding: const EdgeInsets.all(15),
            color: const Color.fromARGB(255, 76, 175, 158),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Complete Task',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(border: Border.all(color: Colors.red)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Delete Task',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.red,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class SubTask extends StatelessWidget {
  SubTask({
    Key? key,
    required this.description,
    required this.isdone, required this.updateSubTask,
  }) : super(key: key);

  final String description;
  final bool isdone;
  final Function updateSubTask;

  var isExpanded = false.obs;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () => isExpanded.value = !isExpanded.value,
      onTap: () => isExpanded.value = false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.green[50],
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                description,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Obx(
                () => isExpanded.value == false
                    ? const Icon(
                        Icons.fiber_manual_record_outlined,
                        size: 14,
                      )
                    : Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          IconButton(
                            onPressed: () => updateSubTask,
                            icon: const Icon(
                              Icons.check_outlined,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
