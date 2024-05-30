import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list_app/models/controller.dart';
import 'package:todo_list_app/models/task.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Controller taskController = Get.put(Controller());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: const Text('Your To-Do List'),
      ),
      body: Obx(() {
        if (taskController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(), // Show a loading indicator
          );
        } else {
          List<Task> tasks = taskController.tasks.toList();

          return SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  tasks.isEmpty
                      ? const Center(
                          child: Text(
                            "No tasks yet",
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: tasks.length,
                          itemBuilder: (BuildContext context, int index) {
                            final task = tasks[index];
                            return ListTile(
                              title: Text(task.title),
                              trailing: IconButton(
                                icon: Icon(
                                  task.isCompleted
                                      ? Icons.check_circle
                                      : Icons.radio_button_unchecked,
                                  color: task.isCompleted
                                      ? Colors.green[300]
                                      : null,
                                ),
                                onPressed: () {
                                  taskController.markTaskCompletion(task);
                                },
                              ),
                              onLongPress: () {
                                String taskTitle = '';
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Edit task:'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextField(
                                            decoration: const InputDecoration(
                                                labelText: 'New title'),
                                            onChanged: (value) {
                                              taskTitle = value;
                                            },
                                          ),
                                          const SizedBox(height: 20.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  if (taskTitle.isNotEmpty) {
                                                    taskController.renameTask(
                                                        task, taskTitle);
                                                    Get.back();
                                                  } else {
                                                    Get.back();
                                                  }
                                                },
                                                child: const Text('Rename'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                taskController.deleteTask(task);
                                                Get.back();
                                              },
                                              child: const Text('Delete'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: const Text('Cancel'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                  const SizedBox(height: 16.0),
                  FloatingActionButton(
                    onPressed: () {
                      String taskTitle = '';
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Create new task'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  decoration:
                                      const InputDecoration(labelText: 'Title'),
                                  onChanged: (value) {
                                    taskTitle = value;
                                  },
                                )
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (taskTitle.isNotEmpty) {
                                    taskController.createNewTask(
                                        taskTitle, false);
                                    Get.back();
                                  }
                                },
                                child: const Text('Create'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
