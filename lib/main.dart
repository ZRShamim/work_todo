import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_to_doo/view/main_screen/task_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: TaskScreen(),
    );
  }
}
