import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddToDO extends StatelessWidget {
  AddToDO({Key? key}) : super(key: key);
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Future<void> addToDo(String title, String description) async {
    try {
      var collection = FirebaseFirestore.instance.collection('todo').doc();
      collection.set({
        'id': collection.id,
        'title': title,
        'description': description,
        'time': Timestamp.now(),
        'userid': '101',
        'isdone': false,
        'subtask':[],
        // 'id':FirebaseFirestore.instance.collection('todo').doc().id,
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Task',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 15,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              if (titleController.text.trim().isNotEmpty) {
                if (descriptionController.text.trim().isNotEmpty) {
                  addToDo(
                      titleController.text,
                      descriptionController
                          .text); //Add new todo to firebase database
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Task Added'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  FocusScope.of(context).unfocus();
                  titleController.text = '';
                  descriptionController.text = '';
                } else {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: const Text('No Description'),
                          content: const Text(
                              'Do you want to add todo task with description?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  // Navigator.of(context).pop();
                                  Get.back();
                                },
                                child: const Text('No')),
                            ElevatedButton(
                                onPressed: () {}, child: const Text('Yes')),
                          ],
                        );
                      });
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Title Required'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            icon: const Icon(Icons.add),
            color: Colors.black,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  keyboardType: TextInputType.text,
                  controller: titleController,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  minLines: 3,
                  maxLines: null,
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  keyboardType: TextInputType.multiline,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
