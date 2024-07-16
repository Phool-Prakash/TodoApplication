class Todo {
  final int id;
  final String title, description;
  final bool completed;

  Todo(
      {required this.id,
      required this.title,
      required this.description,
      required this.completed});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        completed: json['completed']);
  }
}
