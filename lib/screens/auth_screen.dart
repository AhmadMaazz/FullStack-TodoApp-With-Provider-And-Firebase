import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  File? _selectedImage;

  void _showImagePickerDialog() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
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
            ListTile(
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
      body: Column(
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
            ],
          ),
        ],
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paintFill0 = Paint()
      ..color = const Color(0xffBBF0BC)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0, size.height * 0);
    path_0.lineTo(size.width * 0, size.height * 0.9285714);
    path_0.lineTo(size.width * 0.2086667, size.height * 0.9294286);
    path_0.lineTo(size.width * 0.2921667, size.height * 0.8571429);
    path_0.lineTo(size.width * 0.3751667, size.height * 0.9294286);
    path_0.lineTo(size.width * 0.4173333, size.height * 0.9291429);
    path_0.lineTo(size.width * 0.5007250, size.height * 0.8576143);
    path_0.lineTo(size.width * 0.5833333, size.height * 0.9294286);
    path_0.lineTo(size.width * 0.6253333, size.height * 0.9294286);
    path_0.lineTo(size.width * 0.7085000, size.height * 0.8520000);
    path_0.lineTo(size.width * 0.7921667, size.height * 0.9288571);
    path_0.lineTo(size.width * 1, size.height * 0.9285714);
    path_0.lineTo(size.width * 1, size.height * 0);

    canvas.drawPath(path_0, paintFill0);

    // Layer 1

    Paint paintStroke0 = Paint()
      ..color = const Color.fromARGB(255, 187, 240, 188)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(path_0, paintStroke0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
