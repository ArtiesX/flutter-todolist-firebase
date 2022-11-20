import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

User? user = FirebaseAuth.instance.currentUser;

class TaskService {
  // static final CollectionReference _firestore = FirebaseFirestore.instance
  //     .collection("users")
  //     .doc(user!.uid)
  //     .collection("tasks");

  static final CollectionReference _firestore =
      FirebaseFirestore.instance.collection("tasks");

  Future<void> addTask({
    required String title,
    required String details,
    required String date,
    required bool isComplete,
  }) async {
    try {
      await _firestore.add({
        'uid': user!.uid,
        'title': title,
        'details': details,
        'date': date,
        'isComplete': isComplete,
      }).then((value) =>
          print("Insert Data to Firestore Successful to ${user!.uid}"));
    } catch (e) {
      print(e);
    }
  }

  Future<void> editTask(
      {required String id, required Map<String, dynamic> data}) async {
    try {
      await _firestore.doc(id).update(data);
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteTask({required String id}) async {
    try {
      await _firestore.doc(id).delete();
    } catch (e) {
      print(e);
    }
  }
}
