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
}
