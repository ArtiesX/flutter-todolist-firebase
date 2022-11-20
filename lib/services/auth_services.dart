import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todolist_firebase/screens/login.dart';
import 'package:flutter_todolist_firebase/utils/navbar.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.idTokenChanges();

  Future<void> login({required String email, required String password}) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => {})
          .catchError((error) => print("Error : $error"));
      ;
      print("Login Successful");
    } catch (e) {
      print(e);
    }
  }

  Future<void> signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        User? user = FirebaseAuth.instance.currentUser;
        await user!.updateDisplayName(name);
        await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
          'uid': user.uid,
          'email': email,
          'password': password,
          'displayName': name,
        }).then((value) => print("Insert User to Firestore Successful"));
      }).catchError((error) => print("Error : $error"));
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut().then((value) => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
          ModalRoute.withName('/')));
    } catch (e) {
      print(e);
    }
  }

  Future<void> checkAuth(BuildContext context) async {
    try {
      if (_auth.currentUser != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Navbar()));
      } else {
        return;
      }
    } catch (e) {
      print(e);
    }
  }
}
