import 'package:flutter/material.dart';
import 'package:fullstack_todo_app/models/todo.dart';
import 'package:fullstack_todo_app/widgets/my_button.dart';
import 'package:provider/provider.dart';

import '../decorations/textfield_decoration.dart';
import '../provider/todo_provider.dart';
import '../widgets/rps_custompainter.dart';

class TaskDetailScreen extends StatefulWidget {
  final Todo todo;
  final int index;
  const TaskDetailScreen({super.key, required this.todo, required this.index});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  TextEditingController _taskNameController = TextEditingController();
  TextEditingController _taskDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _taskNameController.text = widget.todo.taskName;
    _taskDescriptionController.text = widget.todo.description;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double textSize = MediaQuery.textScaleFactorOf(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                width: size.width,
                height: size.height * 0.17,
                child: CustomPaint(
                  size: Size(
                      size.width,
                      (size.width * 0.2833333333333334)
                          .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                  painter: RPSCustomPainter(),
                ),
              ),
              Positioned(
                left: size.width * 0.32,
                // right: size.width * 0.4,
                top: size.height * 0.09,
                child: Text(
                  'Task details',
                  style: TextStyle(
                    fontSize: textSize * 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                left: size.height * 0.002,
                top: size.height * 0.084,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Text(
              'Task name',
              style: TextStyle(
                fontSize: textSize * 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 30,
            ),
            child: TextField(
              cursorColor: Theme.of(context).colorScheme.secondary,
              controller: _taskNameController,
              keyboardType: TextInputType.name,
              decoration: TextFieldDecorations()
                  .inputDecorationStyle(context, '', 'Enter your Task Name'),
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Text(
              'Task description',
              style: TextStyle(
                fontSize: textSize * 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 30,
            ),
            child: TextField(
              cursorColor: Theme.of(context).colorScheme.secondary,
              controller: _taskDescriptionController,
              keyboardType: TextInputType.text,
              minLines: 3,
              maxLines: 5,
              decoration: TextFieldDecorations().inputDecorationStyle(
                  context, '', 'Enter your Task Description'),
            ),
          ),
          SizedBox(
            height: size.height * 0.1,
          ),
          Align(
            alignment: Alignment.center,
            child: MyButton(
              textSize: textSize,
              width: size.width * 0.85,
              height: size.height * 0.08,
              title: 'Update Task',
              navigation: () {
                if (_taskNameController.text.isNotEmpty) {
                  // Update task in provider
                  final todoProvider =
                      Provider.of<TodoProvider>(context, listen: false);
                  todoProvider.updateTask(
                    widget.todo,
                    _taskNameController.text,
                    _taskDescriptionController.text,
                  );
                }
                Navigator.pop(context);
              },
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Align(
            alignment: Alignment.center,
            child: MyButton(
              textSize: textSize,
              width: size.width * 0.85,
              height: size.height * 0.08,
              title: 'Delete Task',
              navigation: () {
                final todoProvider =
                    Provider.of<TodoProvider>(context, listen: false);
                todoProvider.removeTodo(widget.index);
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
