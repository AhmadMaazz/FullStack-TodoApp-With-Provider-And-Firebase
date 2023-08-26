import 'package:flutter/material.dart';
import 'package:fullstack_todo_app/models/todo.dart';

class TodoProvider extends ChangeNotifier {
  final List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  void addTodo(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void removeTodo(int index) {
    _todos.removeAt(index);
    notifyListeners();
  }

  void toggleTodoCompletion(int index) {
    _todos[index].isCompleted = !_todos[index].isCompleted;
    notifyListeners();
  }

  void updateTask(Todo todo, String newTaskName, String newTaskDescription) {
    final index = _todos.indexOf(todo);
    if (index != -1) {
      _todos[index] = Todo(
        taskName: newTaskName,
        description: newTaskDescription,
        creationTime: todo.creationTime,
        isCompleted: todo.isCompleted,
      );
      notifyListeners();
    }
  }
}
