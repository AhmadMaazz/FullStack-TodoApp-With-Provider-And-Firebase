import 'package:flutter/material.dart';

class MyTasks extends StatelessWidget {
  const MyTasks({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            leading: Checkbox(value: false, onChanged: (_) {}),
            title: const Text('Going to the gym'),
            subtitle: const Text('9:08 pm'),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.movie_edit),
            ),
          ),
        ),
      ),
    );
  }
}