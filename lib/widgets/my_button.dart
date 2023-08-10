import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.textSize,
    required this.width,
    required this.height,
    required this.title, required this.navigation,
  });
  final VoidCallback navigation;
  final double width;
  final double height;
  final double textSize;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: navigation,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
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
        width: width,
        height: height,
        child: Padding(
          padding: EdgeInsets.only(
            left: textSize * 15,
            right: textSize * 15,
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: textSize * 18,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
