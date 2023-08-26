import 'package:flutter/material.dart';
import 'package:fullstack_todo_app/models/todo.dart';
import 'package:provider/provider.dart';

import '../provider/todo_provider.dart';
import '../screens/taskdetails_screen.dart';

class MyTasks extends StatelessWidget {
  const MyTasks({
    super.key,
    required this.size,
    required this.todos,
    required this.index,
  });

  final Size size;
  final List<Todo> todos;
  final int index;

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);
    final todo = todos[index];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        width: size.width * 0.9,
        height: size.height * 0.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            begin: const Alignment(-1.0, -1.0),
            end: const Alignment(1.0, 1.0),
            colors: [
              const Color(0xffEFBBD3),
              Theme.of(context).colorScheme.secondary,
            ], // Specify the colors you want for the gradient
            // You can also add stops to control the color distribution
            stops: const [
              0.2,
              1
            ], // Stops for the colors, ranging from 0.0 to 1.0
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              leading: Checkbox(
                value: todo.isCompleted,
                onChanged: (_) {
                  todoProvider.toggleTodoCompletion(index);
                },
              ),
              title: Text(
                todoProvider.todos[index].taskName,
                style: TextStyle(
                  decoration: todoProvider.todos[index].isCompleted
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
              subtitle: Text(
                todoProvider.todos[index].creationTime,
              ),
              trailing: IconButton(
                onPressed: () {
                  // Navigator.pushNamed(context, '/tastdetailscreen');
                  // todoProvider.removeTodo(index);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskDetailScreen(
                        todo: todo,
                        index: index,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.movie_edit),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
