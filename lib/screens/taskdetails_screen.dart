import 'package:flutter/material.dart';

import '../widgets/rps_custompainter.dart';

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({super.key});

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
        ],
      ),
    );
  }
}
