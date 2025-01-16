class TaskModel {
  final int id;
  final String todo;
  final bool completed;

  TaskModel({
    required this.id,
    required this.todo,
    required this.completed,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    id: json['id'],
    todo: json['todo'],
    completed: json['completed'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'todo': todo,
    'completed': completed,
  };
}
