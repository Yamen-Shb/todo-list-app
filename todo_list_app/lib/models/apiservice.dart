import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo_list_app/models/task.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:3000';

  static Future<List<Task>> fetchTasks() async {
    final response = await http.get(Uri.parse('$baseUrl/tasks'));

    if (response.statusCode == 200) {
      Iterable tasksJson = json.decode(response.body);
      return List<Task>.from(tasksJson.map((json) => Task.fromJson(json)));
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  static Future<Task> createTask(String title) async {
    final response = await http.post(
      Uri.parse('$baseUrl/tasks'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
      }),
    );

    if (response.statusCode == 201) {
      return Task.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create task');
    }
  }

  static Future<void> updateTask(Task task) async {
    final response = await http.put(
      Uri.parse('$baseUrl/tasks/${task.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(task.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update task');
    }
  }

  static Future<void> deleteTask(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/tasks/$id'),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete task');
    }
  }
}
