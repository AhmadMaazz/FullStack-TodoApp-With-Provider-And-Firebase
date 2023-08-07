import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/rps_custompainter.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  File? _selectedImage;

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
                        radius: 63,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey,
                          child: _selectedImage != null
                              ? CircleAvatar(
                                  radius: 60,
                                  backgroundImage: FileImage(_selectedImage!),
                                )
                              : const Icon(
                                  Icons.camera_alt,
                                  size: 60,
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
                vertical: 12.0,
                horizontal: 40,
              ),
              child: TextField(
                cursorColor: Theme.of(context).colorScheme.secondary,
                controller: _fullNameController,
                decoration: inputDecorationStyle(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 40,
              ),
              child: TextField(
                cursorColor: Theme.of(context).colorScheme.secondary,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: inputDecorationStyle(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 40,
              ),
              child: TextField(
                cursorColor: Theme.of(context).colorScheme.secondary,
                controller: _passwordController,
                obscureText: true,
                decoration: inputDecorationStyle(context),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    // Handle Google login
                  },
                  child: Image.asset(
                    'assets/images/google.png', // Replace with your Google icon asset path
                    width: 50,
                    height: 50,
                  ),
                ),
                const VerticalDivider(
                  color: Colors.grey,
                  width: 20,
                  thickness: 1, // Increase thickness
                  indent: 20,
                  endIndent: 0,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  color: Colors.grey.withOpacity(0.4),
                  width: 3,
                ),
                GestureDetector(
                  onTap: () {
                    // Handle Facebook login
                  },
                  child: Image.asset(
                    'assets/images/facebook.png', // Replace with your Facebook icon asset path
                    width: 50,
                    height: 50,
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration inputDecorationStyle(BuildContext context) {
    return InputDecoration(
      labelText: 'Full Name',
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
          width: 3.0,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 3.0,
        ),
        borderRadius: BorderRadius.circular(7.0),
      ),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      filled: true,
      hintText: 'Enter your full name',
    );
  }
}
