import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list_app/pages/home_page.dart';

void main() => runApp(
  const GetMaterialApp(home: ToDoListApp(),debugShowCheckedModeBanner: false)
);

class ToDoListApp extends StatelessWidget {
  const ToDoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}