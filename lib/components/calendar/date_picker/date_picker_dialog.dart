import 'package:flutter/material.dart';
import 'package:flutter_todolist_firebase/utils/style.dart';

import 'custom_date_picker.dart';

class PickerDateDialog extends StatefulWidget {
  final DateTime initialDate;

  const PickerDateDialog({
    Key? key,
    required this.initialDate,
  }) : super(key: key);

  @override
  State<PickerDateDialog> createState() => _PickerDateDialogState();
}

// enum PickerView { Calendar }

class _PickerDateDialogState extends State<PickerDateDialog> {
  // late PickerView _pickerView;
  late DateTime? _date;

  @override
  void initState() {
    _date = widget.initialDate;
    // _pickerView = PickerView.Calendar;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          colorScheme: Theme.of(context).brightness == Brightness.dark
              ? const ColorScheme.dark(
                  brightness: Brightness.dark,
                )
              : const ColorScheme.light(
                  brightness: Brightness.light,
                  primary: primaryColor,
                )),
      child: Dialog(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? bgDarkColor
            : bgLightColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: CustomDatePicker(
          initialDate: widget.initialDate,
          onSelected: (date) => setState(() => _date = date),
          onDone: () => Navigator.pop(
            context,
            {
              'date': _date,
            },
          ),
        ),
      ),
    );
  }
}
