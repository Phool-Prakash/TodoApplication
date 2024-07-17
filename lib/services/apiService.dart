import 'dart:convert';

import 'package:todo_aap/utils/constants.dart';

import '../models/todoModel.dart';
import '../models/userModel.dart';
import 'package:http/http.dart' as http;

class ApiService {
  ///Authentication
  Future<User?> authenticate(String username, String password) async {
    final response = await http.post(
        Uri.parse('${Constants.apiBaseUrl}/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {'username': username, 'password': password, 'expires': 30}));
    if (response.statusCode == 200) {
      print('LogIn Successfully');
      return User.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  ///FetchTodos
  Future<List<Todo>> fetchTodos() async {
    final response = await http.get(Uri.parse('${Constants.apiBaseUrl}/todos'));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      Iterable json = jsonResponse['todos'];
      return List<Todo>.from(json.map((model) => Todo.fromJson(model)));
    } else {
      print('Failed to load todos: ${response.body}');
      throw Exception('Failed to load todos');
    }
  }

  ///AddTodo
  Future<Todo> addTodo(String title, bool completed, int userId) async {
    final response = await http.post(
      Uri.parse('${Constants.apiBaseUrl}/todos/add'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'todo': title,
        'completed': completed,
        'userId': userId,
      }),
    );
    if (response.statusCode == 200) {
      return Todo.fromJson(jsonDecode(response.body));
    } else {
      print('Failed to add todo:${response.body}');
      throw Exception('Failed to add todo');
    }
  }

  ///Delete Todo
  Future<void> deleteTodo(int id) async {
    final response = await http.delete(
      Uri.parse('${Constants.apiBaseUrl}/todos/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      print('Failed to delete todo: ${response.body}');
      throw Exception('Failed to delete todo');
    }
  }

  ///Update Todo
  Future<void> updateTodoCompletion(int id, bool completed) async {
    final response = await http.put(
      Uri.parse('${Constants.apiBaseUrl}/todos/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'completed': completed}),
    );

    if (response.statusCode != 200) {
      print('Failed to update todo: ${response.body}');
      throw Exception('Failed to update todo');
    }
  }
}
