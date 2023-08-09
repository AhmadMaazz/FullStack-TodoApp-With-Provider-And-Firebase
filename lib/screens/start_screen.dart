import 'package:flutter/material.dart';

import '../widgets/my_buttonicon.dart';

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
          MyButtonIcon( textSize: textSize,width: size.width * 0.5,height: size.height * 0.075,title: "let's start"),
        ],
      ),
    );
  }
}

