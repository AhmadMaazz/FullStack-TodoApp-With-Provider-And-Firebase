import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
    required File? selectedImage,
  }) async {
    try {
      if (selectedImage != null) {
        final fileName = 'profile_pictures/${email}_${DateTime.now()}.jpg';

        final ref = firebase_storage.FirebaseStorage.instance.ref(fileName);
        final uploadTask = ref.putFile(File(selectedImage.path));
        final snapshot = await uploadTask;

        if (snapshot.state == firebase_storage.TaskState.success) {
          await _firebaseAuth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );

          final imageUrl = await ref.getDownloadURL();

          final User? user = currentUser;
          if (user != null) {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .set({
              'email': email,
              'username': username,
              'profilePictureUrl': imageUrl,
            });
          }
        }
      }
    } catch (e) {
      debugPrint('Error creating user: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> signOutGoogle() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    final User user = userCredential.user!;
    final String username = user.displayName ?? '';
    final String? profilePictureUrl = user.photoURL;

    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'email': user.email,
      'username': username,
      'profilePictureUrl': profilePictureUrl,
    });

    return userCredential;
  }
}
