import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fullstack_todo_app/widgets/my_button.dart';

import '../firebase/firebase.utils.dart';

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({super.key});

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
    await Auth().signOutGoogle();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double textSize = MediaQuery.textScaleFactorOf(context);
    return Scaffold(
      body: Center(
        child: Container(
          width: size.width * 0.9,
          height: size.height * 0.6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.grey,
              width: 2.0,
            ),
          ),
          child: Column(
            children: [
              Image.asset(
                'assets/images/logut_wbg.png',
                width: 220,
                height: 200,
                fit: BoxFit.fill,
              ),
              Text(
                'Are you sure you want\nto log out?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: textSize * 22,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Urbanist',
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                'If you logged out you would need to re-\nenter the Email and Password if you want\nto enter again',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: textSize * 12,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Urbanist',
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      // backgroundColor: Theme.of(context).primaryColor,
                      side: BorderSide(color: Theme.of(context).primaryColor),
                      minimumSize: Size(
                        size.width * 0.3,
                        size.height * 0.06,
                      ),
                    ),
                    onPressed: () async {
                      await signOut();
                      if (context.mounted) {
                        Navigator.popAndPushNamed(context, '/authscreen');
                      }
                    },
                    child: Text(
                      'Log Out',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: textSize * 18,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  MyButton(
                    textSize: textSize,
                    width: size.width * 0.3,
                    height: size.height * 0.06,
                    title: 'Cancel',
                    navigation: () {
                      Navigator.popAndPushNamed(context, '/homescreen');
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
