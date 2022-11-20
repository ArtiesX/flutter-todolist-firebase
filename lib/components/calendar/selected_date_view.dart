import 'package:flutter/material.dart';
import 'package:flutter_todolist_firebase/utils/style.dart';
import 'package:intl/intl.dart';

import 'methods.dart';

class SelectedDateView extends StatelessWidget {
  final DateTime dateTime;

  final Function(DateTime?) onSelected;
  final bool enabled;

  const SelectedDateView({
    Key? key,
    required this.dateTime,
    required this.onSelected,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: enabled
                ? () => showPickerDate(
                      context: context,
                      initialDate: dateTime,
                      onSelected: onSelected,
                    )
                : null,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, .0, 8.0),
              child: Text(
                DateFormat("EEE, MMM dd").format(dateTime).toString(),
                style: const TextStyle(
                  fontSize: 12.0,
                  color: customGreyColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          if (enabled)
            InkWell(
              onTap: () => onSelected(null),
              customBorder: const CircleBorder(),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                child: Icon(
                  Icons.close,
                  size: 20.0,
                  color: customGreyColor,
                ),
              ),
            )
          else
            const SizedBox(width: 8.0),
        ],
      ),
    );
  }
}
