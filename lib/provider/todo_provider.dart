import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fullstack_todo_app/models/todo.dart';

import '../firebase/firebase.utils.dart';

class TodoProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  void addTodo(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  // void removeTodo(int index) {
  //   _todos.removeAt(index);
  //   notifyListeners();
  // }

  void removeTodo(int index) async {
    // Check if the index is within the valid range
    if (index >= 0 && index < _todos.length) {
      final Todo todo = _todos[index];

      // Remove the task from Firestore
      final user = Auth().currentUser;
      if (user != null) {
        final userTasksRef =
            _firestore.collection('users').doc(user.uid).collection('tasks');

        // Retrieve the list of tasks for the user
        final tasksSnapshot = await userTasksRef.get();

        // Find the Firestore-generated document ID of the task to delete
        final taskToDelete = tasksSnapshot.docs.firstWhere((doc) =>
            doc['taskName'] == todo.taskName &&
            doc['description'] == todo.description &&
            doc['creationTime'] == todo.creationTime);

        if (taskToDelete != null) {
          await userTasksRef.doc(taskToDelete.id).delete();
        }
      }

      // Remove the task from the local list and update the UI
      _todos.removeAt(index);
      notifyListeners();
    }
  }

  void toggleTodoCompletion(int index) {
    _todos[index].isCompleted = !_todos[index].isCompleted;
    notifyListeners();
  }

  // void updateTask(Todo todo, String newTaskName, String newTaskDescription) {
  //   final index = _todos.indexOf(todo);
  //   if (index != -1) {
  //     _todos[index] = Todo(
  //       taskName: newTaskName,
  //       description: newTaskDescription,
  //       creationTime: todo.creationTime,
  //       isCompleted: todo.isCompleted,
  //     );
  //     notifyListeners();
  //   }
  // }

  void updateTask(
      Todo todo, String newTaskName, String newTaskDescription) async {
    // Find the index of the task in the local list
    final index = _todos.indexOf(todo);

    if (index != -1) {
      // Find the Firestore-generated document ID of the task to update
      final user = Auth().currentUser;
      if (user != null) {
        final userTasksRef =
            _firestore.collection('users').doc(user.uid).collection('tasks');

        // Retrieve the list of tasks for the user
        final tasksSnapshot = await userTasksRef.get();

        // Find the Firestore-generated document ID of the task to update
        final taskToUpdate = tasksSnapshot.docs.firstWhere(
          (doc) =>
              doc['taskName'] == todo.taskName &&
              doc['description'] == todo.description &&
              doc['creationTime'] == todo.creationTime,
        );

        if (taskToUpdate != null) {
          final taskId = taskToUpdate.id;

          // Update the task in Firestore
          await userTasksRef.doc(taskId).update({
            'taskName': newTaskName,
            'description': newTaskDescription,
          });

          // Update the task in the local list and update the UI
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
