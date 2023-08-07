import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double textSize = MediaQuery.textScaleFactorOf(context);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.5,
            width: size.width,
            child: const Image(
              image: AssetImage(
                'assets/images/picOfNotes.jpg',
              ),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: size.height * 0.09,
          ),
          Padding(
            padding: EdgeInsets.only(left: textSize * 25),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Welcome,',
                style: TextStyle(
                  fontSize: textSize * 30,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: textSize * 25,
              right: textSize * 65,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Manage your Tasks easily And achieve your goals, like a piece of cake!',
                style: TextStyle(
                  color: const Color(0xff9D9D9D),
                  fontSize: textSize * 23,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.07,
          ),
          MyButton(size: size, textSize: textSize),
        ],
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.size,
    required this.textSize,
  });

  final Size size;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/authscreen');
      },
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
        width: size.width * 0.5,
        height: size.height * 0.075,
        child: Padding(
          padding: EdgeInsets.only(
            left: textSize * 15,
            right: textSize * 15,
          ),
          child: ListTile(
            leading: Text(
              "let's start",
              style: TextStyle(
                color: Colors.black,
                fontSize: textSize * 18,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: const Icon(Icons.arrow_circle_right_outlined),
          ),
        ),
      ),
    );
  }
}
