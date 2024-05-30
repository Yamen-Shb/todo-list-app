import 'package:get/get.dart';
import 'package:todo_list_app/models/task.dart';

class Controller extends GetxController {
  RxList<Task> tasks = <Task>[].obs;

  void createNewTask(String title, bool isCompleted) {
    Task task = Task(title: title, isCompleted: isCompleted);
    addTask(task);
  }

  void addTask(Task task) {
    tasks.add(task);
    update();
  }

  void deleteTask(Task task) {
    tasks.remove(task);
    update();
  }

  void markTaskCompletion(Task task) {
    task.isCompleted = !task.isCompleted;
    if (task.isCompleted) {
      moveTaskToBottom(task);
    }
    else {
      moveTaskToTop(task);
    }
    update();
  }

  void renameTask(Task task, String newTitle) {
    task.title = newTitle;
    update();
  }

  void moveTaskToBottom(Task task) {
    tasks.remove(task);
    tasks.add(task);
  }

  void moveTaskToTop(Task task) {
    tasks.remove(task);
    tasks.insert(0, task);
  }
}