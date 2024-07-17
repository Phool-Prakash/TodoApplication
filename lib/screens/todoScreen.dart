import 'package:flutter/material.dart';
import 'package:todo_aap/customExtension/customExtension.dart';
import 'package:todo_aap/services/apiService.dart';
import 'package:todo_aap/theme/myColors.dart';
import '../models/todoModel.dart';
import 'addTodoScreen.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({
    super.key,
  });

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  late Future<List<Todo>> _todos;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _todos = ApiService().fetchTodos();
  }

  ///AddTodo
  void _navigateToAddTodo() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return AddTaskBottomSheet();
        }).then((value) {
      if (value == true) {
        setState(() {
          _todos = ApiService().fetchTodos();
        });
      }
    });
  }

  ///DeleteTodo
  Future<void> _deleteTodo(int id) async {
    try {
      await ApiService().deleteTodo(id);
      setState(() {
        _todos = ApiService().fetchTodos(); // Refresh the todo list
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Todo deleted')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting todo: $e')),
      );
    }
  }

  ///UpdateTodo
  Future<void> _toggleTodoCompletion(Todo todo) async {
    try {
      await ApiService().updateTodoCompletion(todo.id, !todo.completed);
      setState(() {
        todo.completed = !todo.completed; // Update the local state
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating todo: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      ///FAButton for Add Todo
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorTheme.blackBold,
        onPressed: _navigateToAddTodo,
        child: const Icon(
          Icons.add,
          color: ColorTheme.whiteBold,
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorTheme.whiteBold,
        actions: [
          const CircleAvatar(
            backgroundImage: AssetImage('assets/profilepic.png'),
          ).padAll(8)
        ],
      ),
      body: isLoading
          ? const CircularProgressIndicator()
          : FutureBuilder<List<Todo>>(
              future: _todos,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text('Error loading todos: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No todos found.'));
                } else {
                  final todos = snapshot.data!;
                  return ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      return ListTile(

                        ///CheckBox
                          leading: Checkbox(
                            value: todos[index].completed,
                            onChanged: (value) {
                              _toggleTodoCompletion(todos[index]);
                            },
                          ),
                          textColor: Colors.black,
                          titleTextStyle: const TextStyle(color: Colors.black),
                          title: Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              todos[index].title.isNotEmpty
                                  ? todos[index].title
                                  : 'No title',
                              style: TextStyle(
                                  color: Colors.black,
                                  decoration: todos[index].completed
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none),
                            ).padAll(8),
                          ),

                          ///Delete
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteTodo(todos[index].id),
                          ));
                    },
                  );
                }
              },
            ),
    );
  }
}
