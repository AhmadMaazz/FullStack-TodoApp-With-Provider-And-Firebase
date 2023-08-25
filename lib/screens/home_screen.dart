import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fullstack_todo_app/firebase/firebase.utils.dart';
import 'package:fullstack_todo_app/widgets/rps_custompainter.dart';

import '../widgets/my_task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
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
                left: size.width * 0.25,
                right: size.width * 0.2,
                top: size.height * 0.07,
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.pink,
                  ),
                  title: Text('Hello! ${user?.displayName ?? 'User email'}'),
                ),
              ),
              Positioned(
                top: size.height * 0.075, // Adjust the top position as needed
                left: 10, // Adjust the left position as needed
                child: Builder(
                  // Wrap the IconButton with a Builder widget
                  builder: (BuildContext context) {
                    return IconButton(
                      icon: const Icon(Icons.menu), // Icon for the drawer
                      onPressed: () {
                        Scaffold.of(context).openDrawer(); // Open the drawer
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: textSize * 15,
                vertical: textSize * 25,
              ),
              child: Text(
                'Today Tasks:',
                style: TextStyle(
                  fontSize: textSize * 20,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          MyTasks(size: size),
          MyTasks(size: size),
          MyTasks(size: size),
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/addtaskscreen');
        },
        child: Container(
          width: 60, // Set the width and height to make it circular
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
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
          child: const Icon(Icons.add),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: Column(
          children: [
            const DrawerHeader(
              child: Icon(Icons.favorite),
            ),
            ListTile(
                leading: const Icon(Icons.home),
                title: const Text('D A S H B O A R D'),
                onTap: () {}),
            const ListTile(
              leading: Icon(Icons.logout),
              title: Text('L O G O U T'),
            ),
            const ListTile(
              leading: Icon(Icons.info),
              title: Text('T E R M S & P O L I C Y'),
            ),
          ],
        ),
      ),
    );
  }
}



// Text(
//             user?.email ?? 'User email',
//             style: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.orange,
//             ),
//             onPressed: () async {
//               await signOut();
//               if (context.mounted) Navigator.pop(context);
//             },
//             child: const Text('sign out'),
//           ),