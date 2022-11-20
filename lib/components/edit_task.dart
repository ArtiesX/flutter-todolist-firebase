import 'package:flutter/material.dart';
import 'package:flutter_todolist_firebase/services/tasks_services.dart';
import 'package:flutter_todolist_firebase/utils/style.dart';

import 'calendar/selected_date_view.dart';

class EditTask extends StatefulWidget {
  final String id, title, details, date;
  const EditTask({
    super.key,
    required this.id,
    required this.title,
    required this.details,
    required this.date,
  });

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  late DateTime _dateTime;

  @override
  void initState() {
    _titleController.text = widget.title;
    _detailsController.text = widget.details;
    _dateTime = DateTime.parse(widget.date);
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Wrap(
        children: [
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(10.0, 16.0, 10.0, 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: customGreyColor),
                        )),
                    TextButton(
                        onPressed: () async {
                          await TaskService().editTask(id: widget.id, data: {
                            'title': _titleController.text.trim(),
                            'details': _detailsController.text.trim(),
                            'date': _dateTime.toString(),
                          }).then((value) => Navigator.pop(context));
                        },
                        child: const Text(
                          "Save",
                          style: TextStyle(color: primaryColor),
                        )),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      autofocus: true,
                      controller: _titleController,
                      style: const TextStyle(fontSize: 20.0),
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: 'Task'),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.format_align_left),
                        const SizedBox(width: 20.0),
                        Expanded(
                          child: TextField(
                            controller: _detailsController,
                            style: const TextStyle(fontSize: 14.0),
                            decoration: const InputDecoration(
                                border: InputBorder.none, hintText: 'details'),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.calendar_month),
                        const SizedBox(width: 20.0),
                        SelectedDateView(
                          dateTime: _dateTime,
                          onSelected: (date) => setState(() {
                            _dateTime = date!;
                          }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
