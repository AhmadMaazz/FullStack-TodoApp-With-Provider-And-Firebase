import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fullstack_todo_app/models/todo.dart';

class TodoProvider extends ChangeNotifier {
  List<Todo> _todos = [];

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

  Future<void> setUserTasks(String userId) async {
    try {
      final tasksSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .get();

      final List<Todo> fetchedTasks = tasksSnapshot.docs.map((doc) {
        final data = doc.data();
        return Todo(
          taskName: data['taskName'] ?? '',
          description: data['description'] ?? '',
          creationTime: data['creationTime'] ?? '',
          isCompleted: data['isCompleted'] ?? false,
        );
      }).toList();

      _todos = fetchedTasks;
      notifyListeners();
    } catch (error) {
      // Handle error gracefully (display error message or retry)
      debugPrint('Error fetching user tasks: $error');
    }
  }

}
