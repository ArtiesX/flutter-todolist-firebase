import 'package:flutter/material.dart';
import 'package:flutter_todolist_firebase/components/calendar/methods.dart';
import 'package:flutter_todolist_firebase/services/tasks_services.dart';

import 'calendar/selected_date_view.dart';

class NewTask extends StatefulWidget {
  const NewTask({super.key});

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  bool _viewDetailsField = false;
  DateTime? _dateTime;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _titleController,
                  autofocus: true,
                  decoration: const InputDecoration(
                      hintText: 'Task', border: InputBorder.none),
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                ),
                if (_viewDetailsField)
                  TextField(
                    controller: _detailsController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Add details',
                      hintStyle: TextStyle(fontSize: 14.0),
                    ),
                    autocorrect: false,
                    keyboardType: TextInputType.text,
                  ),
                if (_dateTime != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: SelectedDateView(
                      dateTime: _dateTime!,
                      onSelected: (date) => setState(() {
                        _dateTime = date;
                      }),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, .0, 16.0, 16.0),
            child: Row(
              children: <Widget>[
                detailsButton(),
                dateButton(),
                const Spacer(),
                saveButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget dateButton() => Material(
        color: Colors.transparent,
        child: InkWell(
          highlightColor: Theme.of(context).accentColor.withOpacity(0.3),
          customBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
          onTap: () => showPickerDate(
            context: context,
            initialDate: _dateTime ??
                DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day),
            onSelected: (date) => setState(() {
              _dateTime = date;
            }),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Icon(
              Icons.calendar_month,
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
      );

  Widget detailsButton() => Material(
        color: Colors.transparent,
        child: InkWell(
          highlightColor: Theme.of(context).accentColor.withOpacity(0.3),
          customBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
          onTap: () => setState(() => _viewDetailsField = !_viewDetailsField),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Icon(
              Icons.format_align_left,
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
      );

  Widget saveButton() => TextButton(
        onPressed: () async {
          if (_titleController.text.isNotEmpty) {
            await TaskService()
                .addTask(
                    title: _titleController.text.trim(),
                    details: _viewDetailsField == true
                        ? _detailsController.text.trim()
                        : "",
                    date: _dateTime == null
                        ? "0000-00-00 00:00:00.000"
                        : _dateTime.toString(),
                    isComplete: false)
                .then((value) => Navigator.pop(context));
          }
          // if (_taskEditingController.text.isNotEmpty) {
          //   final id = Random.secure().nextInt((2 ^ 31));
          //   context.read<HomeBloc>().add(
          //         HomeEvent.addTask(
          //           Task(
          //             id: id,
          //             name: _taskEditingController.text,
          //             order: 0,
          //             details: _detailsEditingController.text,
          //             dateTime: _dateTime,
          //             timeOfDay: _timeOfDay,
          //           ),
          //         ),
          //       );
          //   Navigator.pop(context);
          // }
        },
        child: Text(
          'Save',
          style: TextStyle(
            fontSize: 15.0,
            color: Theme.of(context).accentColor,
          ),
        ),
      );
}
