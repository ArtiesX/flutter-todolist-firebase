import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todolist_firebase/components/edit_task.dart';
import 'package:flutter_todolist_firebase/services/tasks_services.dart';
import 'package:intl/intl.dart';

import '../components/listview.dart';

class TomorrowPage extends StatefulWidget {
  const TomorrowPage({super.key});

  @override
  State<TomorrowPage> createState() => _TomorrowPageState();
}

class _TomorrowPageState extends State<TomorrowPage> {
  User? user = FirebaseAuth.instance.currentUser;
  final tomorrow = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day + 1)
      .toString();
  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('tasks')
              .where('uid', isEqualTo: user!.uid)
              .where('date', isEqualTo: tomorrow.toString())
              .snapshots(),
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (ctx, i) {
                  final doc = snapshot.data!.docs[i];
                  // final date =
                  //     DateFormat("dd, MMM").format(DateTime.parse(doc['date']));
                  return CustomList(
                      isChecked: doc['isComplete'],
                      onChanged: (value) {
                        FirebaseFirestore.instance
                            .collection("tasks")
                            .doc(doc.id)
                            .update({
                          'isComplete': !doc['isComplete'],
                        });
                      },
                      title: doc['title'],
                      details: doc['details'],
                      onDelete: () async {
                        await TaskService().deleteTask(id: doc.id);
                      },
                      onTap: () {
                        showEdit(
                            id: doc.id,
                            title: doc['title'],
                            details: doc['details'],
                            date: doc['date']);
                      });
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  void showEdit(
      {required String id,
      required String title,
      required String details,
      required String date}) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      builder: (_) => EditTask(
        id: id,
        title: title,
        details: details,
        date: date,
      ),
    );
  }
}
