import 'package:flutter/material.dart';
import 'package:fullstack_todo_app/decorations/textfield_decoration.dart';

import '../widgets/my_button.dart';
import '../widgets/rps_custompainter.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailControllerLogin = TextEditingController();

  final TextEditingController _passwordControllerLogin =
      TextEditingController();
  bool _isPasswordVisibleLogin = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double textSize = MediaQuery.textScaleFactorOf(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
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
                  top: 60,
                  left: 8,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: size.height * 0.01),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Welcome Back !',
                style: TextStyle(
                  fontSize: textSize * 30,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 40,
              ),
              child: TextField(
                cursorColor: Theme.of(context).colorScheme.secondary,
                controller: _emailControllerLogin,
                keyboardType: TextInputType.emailAddress,
                decoration: TextFieldDecorations().inputDecorationStyle(
                    context, 'Email Address', 'Enter your email address'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 40,
              ),
              child: TextField(
                cursorColor: Theme.of(context).colorScheme.secondary,
                controller: _passwordControllerLogin,
                obscureText: !_isPasswordVisibleLogin,
                onChanged: (value) {
                  setState(() {
                    _isPasswordVisibleLogin =
                        value.isNotEmpty ? _isPasswordVisibleLogin : false;
                  });
                },
                decoration: inputDecorationStylePasswordLogin(
                    context, 'Password', 'Enter your password'),
              ),
            ),
            SizedBox(height: size.height * 0.05),
            MyButton(
              navigation: () {
                Navigator.pushReplacementNamed(context, '/homescreen');
              },
              textSize: textSize,
              width: size.width * 0.85,
              height: size.height * 0.07,
              title: 'Log in',
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  InputDecoration inputDecorationStylePasswordLogin(
      BuildContext context, String title, String hinttext) {
    return InputDecoration(
      labelText: title,
      labelStyle: const TextStyle(
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w500,
      ),
      floatingLabelStyle: TextStyle(
          color: Theme.of(context).primaryColor,
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w600),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(7.0),
      ),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      filled: true,
      hintText: hinttext,
      suffixIcon: _passwordControllerLogin.text.isNotEmpty
          ? IconButton(
              icon: Icon(_isPasswordVisibleLogin
                  ? Icons.visibility
                  : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _isPasswordVisibleLogin = !_isPasswordVisibleLogin;
                });
              },
            )
          : null,
    );
  }
}
