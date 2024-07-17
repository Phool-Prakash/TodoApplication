class Todo {
  final int id;
  final String title;
  late final bool completed;

  Todo(
      {required this.id,
      required this.title,
      required this.completed});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
        id: json['id'] ?? 0,
        title: json['todo']?? '',
        completed: json['completed']?? false);
  }

  ///Update todo
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'todo': title,
      'completed': completed,
    };
  }
}
