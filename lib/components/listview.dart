import 'package:flutter/material.dart';

import '../utils/style.dart';
import 'checkbox.dart';

class TaskList extends StatelessWidget {
  final bool isChecked;
  final void Function(bool?)? onChanged;
  final String title, details, isDate, date;
  final void Function()? onTap;

  const TaskList({
    super.key,
    required this.isChecked,
    required this.onChanged,
    required this.title,
    required this.details,
    required this.isDate,
    required this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[100],
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            CustomCheckbox(
              value: isChecked,
              onChanged: onChanged,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title),
                  if (details != "")
                    Column(
                      children: [
                        const SizedBox(height: 5),
                        Text(
                          details,
                          style: const TextStyle(
                            color: customGreyColor,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            const Spacer(),
            Column(
              children: <Widget>[
                if (isDate != "0000-00-00 00:00:00.000") Text(date),
                // if (doc['date'] == "0000-00-00 00:00:00.000")
                //   const Text('No Date'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomList extends StatelessWidget {
  final bool isChecked;
  final void Function(bool?)? onChanged;
  final void Function()? onDelete, onTap;
  final String title, details;
  const CustomList({
    super.key,
    required this.isChecked,
    required this.onChanged,
    required this.title,
    required this.details,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[100],
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            CustomCheckbox(
              value: isChecked,
              onChanged: onChanged,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title),
                  if (details != "")
                    Column(
                      children: [
                        const SizedBox(height: 5),
                        Text(
                          details,
                          style: const TextStyle(
                            color: customGreyColor,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            const Spacer(),
            IconButton(
                onPressed: onDelete,
                icon: const Icon(
                  Icons.delete_rounded,
                  color: errorColor,
                ))
          ],
        ),
      ),
    );
  }
}
