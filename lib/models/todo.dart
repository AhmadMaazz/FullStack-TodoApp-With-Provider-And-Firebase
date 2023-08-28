class Todo {
  final String taskName;
  final String description;
  final String creationTime;
  bool isCompleted;

  Todo({
    required this.taskName,
    required this.description,
    required this.creationTime,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'taskName': taskName,
      'description': description,
      'creationTime': creationTime,
      'isCompleted': isCompleted,
    };
  }

  Todo.fromJson(Map<String, dynamic> data)
    : taskName = data['taskName'] ?? '',
      description = data['description'] ?? '',
      creationTime = data['creationTime'] ?? '',
      isCompleted = data['isCompleted'] ?? false;
}
