// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:fullstack_todo_app/decorations/textfield_decoration.dart';
import 'package:image_picker/image_picker.dart';

import '../firebase/firebase.utils.dart';
import '../widgets/my_button.dart';
import '../widgets/rps_custompainter.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  File? _selectedImage;
  bool _isPasswordVisible = false;
  String? errorMessage = '';

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        username: _fullNameController.text.toString(),
        email: _emailController.text.toString(),
        password: _passwordController.text.toString(),
        selectedImage: _selectedImage,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  void _showImagePickerDialog() {
    showModalBottomSheet<void>(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 15.0,
                left: 8.0,
                right: 8.0,
                bottom: 5,
              ),
              child: ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a Photo'),
                onTap: () async {
                  Navigator.pop(context);
                  final image = await ImagePicker().pickImage(
                    source: ImageSource.camera,
                  );
                  if (image != null) {
                    setState(() {
                      _selectedImage = File(image.path);
                    });
                  }
                },
              ),
            ),
            const Divider(
              indent: 30,
              endIndent: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 5.0,
                left: 8.0,
                right: 8.0,
                bottom: 20,
              ),
              child: ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () async {
                  Navigator.pop(context);

                  final image = await ImagePicker().pickImage(
                    source: ImageSource.gallery,
                  );
                  if (image != null) {
                    setState(() {
                      _selectedImage = File(image.path);
                    });
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

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
                Padding(
                  padding: EdgeInsets.only(top: textSize * 100),
                  child: Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: _showImagePickerDialog,
                      child: CircleAvatar(
                        radius: 53,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey,
                          child: _selectedImage != null
                              ? CircleAvatar(
                                  radius: 50,
                                  backgroundImage: FileImage(_selectedImage!),
                                )
                              : const Icon(
                                  Icons.camera_alt,
                                  size: 50,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'profile photo',
                style: TextStyle(
                    fontSize: textSize * 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Urbanist'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 40,
              ),
              child: TextField(
                cursorColor: Theme.of(context).colorScheme.secondary,
                controller: _fullNameController,
                decoration: TextFieldDecorations().inputDecorationStyle(
                    context, 'Full Name', 'Enter your full name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 40,
              ),
              child: TextField(
                cursorColor: Theme.of(context).colorScheme.secondary,
                controller: _emailController,
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
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                onChanged: (value) {
                  setState(() {
                    _isPasswordVisible =
                        value.isNotEmpty ? _isPasswordVisible : false;
                  });
                },
                decoration: inputDecorationStylePassword(
                    context, 'Password', 'Enter your password'),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'sign in with',
              style: TextStyle(
                  fontSize: textSize * 15,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Urbanist'),
            ),
            const SizedBox(height: 20),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () async {
                      await Auth().signInWithGoogle();
                      Navigator.pushNamed(context, '/homescreen');
                    },
                    child: Image.asset(
                      'assets/images/google.png', // Replace with your Google icon asset path
                      width: 40,
                      height: 40,
                    ),
                  ),
                  const VerticalDivider(
                    // color: Colors.grey,
                    width: 60,
                    indent: 6,
                    endIndent: 6,
                    thickness: 1, // Increase thickness
                  ),
                  GestureDetector(
                    onTap: () {
                      // await Auth().signInWithFacebook();
                      // Navigator.pushNamed(context, '/homescreen');
                      // Handle Facebook login
                    },
                    child: Image.asset(
                      'assets/images/facebook.png', // Replace with your Facebook icon asset path
                      width: 40,
                      height: 40,
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            const SizedBox(height: 20),
            MyButton(
              textSize: textSize,
              width: size.width * 0.85,
              height: size.height * 0.07,
              title: 'Create Your Profile',
              navigation: () async {
                if (_emailController.text.isEmpty ||
                    _passwordController.text.isEmpty ||
                    _fullNameController.text.isEmpty) {
                  // Show a snackbar or some other feedback to indicate validation error
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please fill in all fields."),
                    ),
                  );
                  return; // Prevent navigation
                }

                // firebase_storage.Reference ref = firebase_storage
                //     .FirebaseStorage.instance
                //     .ref('/userprofilepic${DateTime.now()}');

                // firebase_storage.UploadTask uploadTask =
                //     ref.putFile(_selectedImage!.absolute);

                // await Future.value(uploadTask);
                // var newUrl = ref.getDownloadURL();

                await createUserWithEmailAndPassword();
                // Navigator.pushReplacementNamed(context, '/homescreen');
              },
            ),
            const SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: textSize * 68),
              child: ListTile(
                title: Text(
                  'have an account?',
                  style: TextStyle(
                      fontSize: textSize * 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Urbanist'),
                ),
                trailing: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/loginscreen');
                  },
                  child: Text(
                    'log in',
                    style: TextStyle(
                      fontSize: textSize * 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Urbanist',
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: textSize * 30.0, top: textSize * 15),
              child: Text.rich(
                TextSpan(
                  text: 'By continuing, you agree to our ',
                  children: [
                    TextSpan(
                      text: 'Terms, Community Guidelines & Privacy Policy',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  InputDecoration inputDecorationStylePassword(
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
      suffixIcon: _passwordController.text.isNotEmpty
          ? IconButton(
              icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            )
          : null,
    );
  }
}
