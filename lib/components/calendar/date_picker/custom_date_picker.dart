import 'package:flutter/material.dart';
import 'package:flutter_todolist_firebase/utils/style.dart';

class CustomDatePicker extends StatelessWidget {
  final DateTime initialDate;
  final TimeOfDay? timeOfDay;
  final Function(DateTime?) onSelected;
  final VoidCallback onDone;
  const CustomDatePicker({
    Key? key,
    required this.initialDate,
    required this.onSelected,
    this.timeOfDay,
    required this.onDone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
            child: CalendarDatePicker(
              initialDate: initialDate,
              firstDate: DateTime(DateTime.now().year - 30),
              lastDate: DateTime(DateTime.now().year + 30),
              onDateChanged: (date) => onSelected(date),
            ),
          ),
          // InkWell(
          //   onTap: () => onPickerChanged(PickerView.Time),
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
          //     child: Row(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsets.all(12.0),
          //           child: Icon(CommunityMaterialIcons.clock_outline),
          //         ),
          //         Expanded(
          //           child: Container(
          //             padding: const EdgeInsets.all(8.0),
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(6.0),
          //               color: Theme.of(context).dividerColor,
          //             ),
          //             child: Text(
          //               timeOfDay?.format(context) ?? 'Set time',
          //               style: TextStyle(fontSize: 12.0),
          //             ),
          //           ),
          //         ),
          //         const SizedBox(width: 16.0),
          //       ],
          //     ),
          //   ),
          // ),
          Container(
            alignment: AlignmentDirectional.centerEnd,
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: customGreyColor,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: onDone,
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
