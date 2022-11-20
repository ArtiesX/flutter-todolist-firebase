import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/edit_task.dart';
import '../components/listview.dart';

class UpComingPage extends StatefulWidget {
  const UpComingPage({super.key});

  @override
  State<UpComingPage> createState() => _UpComingPageState();
}

class _UpComingPageState extends State<UpComingPage> {
  User? user = FirebaseAuth.instance.currentUser;
  final tomorrow = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day + 1)
      .toString();
  final today =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
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
              .where('date', whereNotIn: [
            today.toString(),
            tomorrow.toString()
          ]).snapshots(),
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (ctx, i) {
                  final doc = snapshot.data!.docs[i];
                  final date = DateFormat("EEE, MMM dd")
                      .format(DateTime.parse(doc['date']));
                  return TaskList(
                      isChecked: doc['isComplete'],
                      onChanged: (value) {
                        FirebaseFirestore.instance
                            .collection("tasks")
                            .doc(doc.id)
                            .update({
                          'isComplete': !doc['isComplete'],
                        }).then((value) => print(today.toString()));
                      },
                      title: doc['title'],
                      details: doc['details'],
                      isDate: doc['date'],
                      date: date.toString(),
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
