import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fullstack_todo_app/firebase/firebase.utils.dart';
import 'package:fullstack_todo_app/provider/todo_provider.dart';
import 'package:fullstack_todo_app/widgets/rps_custompainter.dart';
import 'package:provider/provider.dart';

import '../widgets/my_task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _fetchUserTasks();
  }

  Future<Map<String, dynamic>> getUserData() async {
    if (user != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid) // Use the user's UID to fetch their data
          .get();

      return userDoc.data() as Map<String, dynamic>;
    } else {
      throw Exception;
    }
  }

  Future<void> _fetchUserTasks() async {
    if (user != null) {
      Provider.of<TodoProvider>(context, listen: false)
          .setUserTasks(user!.uid); // Pass userId here
    }
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
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
              // Positioned(
              //   left: size.width * 0.25,
              //   right: size.width * 0.2,
              //   top: size.height * 0.07,
              //   child: ListTile(
              //     leading: const CircleAvatar(
              //       backgroundColor: Colors.pink,
              //     ),
              //     title: Text('Hello! ${user?.displayName ?? 'User email'}'),
              //   ),
              // ),
              FutureBuilder<Map<String, dynamic>>(
                future: getUserData(), // Use the function to fetch user data
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // While waiting for data to be fetched, you can display a loading indicator
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    // Handle any errors that may occur
                    return Text('Error: ${snapshot.error}');
                  } else {
                    // Once the data is fetched, use it to display the user's profile picture and name
                    final userData = snapshot.data;
                    final userProfilePictureURL =
                        userData!['profilePictureUrl'];
                    final userDisplayName = userData['username'];

                    return Positioned(
                      left: size.width * 0.25,
                      right: size.width * 0.2,
                      top: size.height * 0.07,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.pink,
                          backgroundImage: NetworkImage(userProfilePictureURL),
                        ),
                        title:
                            Text('Hello! ${userDisplayName ?? 'User email'}'),
                      ),
                    );
                  }
                },
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
          for (int index = 0; index < todoProvider.todos.length; index++)
            MyTasks(
              size: size,
              todos: todoProvider.todos,
              index: index,
            ),
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
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('L O G O U T'),
              onTap: () => Navigator.pushNamed(context, '/logoutscreen'),
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
