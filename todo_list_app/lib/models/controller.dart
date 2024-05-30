import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list_app/models/apiservice.dart';
import 'package:todo_list_app/models/task.dart';

class Controller extends GetxController {
  RxList<Task> tasks = <Task>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  void fetchTasks() async {
    try {
      List<Task> fetchedTasks = await ApiService.fetchTasks();
      tasks.assignAll(fetchedTasks);
    } catch (e) {
      // Handle error
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void createNewTask(String title, bool isCompleted) async {
    try {
      Task task = await ApiService.createTask(title);
      tasks.add(task);
      update();
    } catch (e) {
      // Handle error
      debugPrint(e.toString());
    }
  }

  void deleteTask(Task task) async {
    try {
      await ApiService.deleteTask(task.id);
      tasks.remove(task);
      update();
    } catch (e) {
      // Handle error
      debugPrint(e.toString());
    }
  }

  void markTaskCompletion(Task task) async {
    task.isCompleted = !task.isCompleted;
    try {
       await ApiService.updateTask(task);
      tasks[tasks.indexOf(task)] = task;
      update();
      if (task.isCompleted) {
        moveTaskToBottom(task);
      }
      else {
        moveTaskToTop(task);
      }
    }
    catch (e) {
      // Handle error
      debugPrint(e.toString());
    }
  }

  void renameTask(Task task, String newTitle) async {
    task.title = newTitle;
    try {
      await ApiService.updateTask(task);
      tasks[tasks.indexOf(task)] = task;
      update();
    }
    catch (e) {
      // Handle error
      debugPrint(e.toString());
    }
  }

  void moveTaskToBottom(Task task) {
    tasks.remove(task);
    tasks.add(task);
    update();
  }

  void moveTaskToTop(Task task) {
    tasks.remove(task);
    tasks.insert(0, task);
    update();
  }
}