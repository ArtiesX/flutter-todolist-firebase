import 'package:flutter/material.dart';

import 'date_picker/date_picker_dialog.dart';

void showPickerDate({
  required BuildContext context,
  required DateTime initialDate,
  required Function(DateTime?) onSelected,
}) {
  showDialog(
    context: context,
    builder: (_) => PickerDateDialog(
      initialDate: initialDate,
    ),
  ).then((value) {
    if (value != null) {
      onSelected(value['date']);
    }
  });
}

// void scheduleNotification({
//   required int id,
//   required String title,
//   String? body,
//   required DateTime dateTime,
// }) {
//   try {
//     final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     const notificationDetails = NotificationDetails(
//       android: AndroidNotificationDetails(
//         'task_reminder',
//         'Task Reminder',
//         'Reminder for timed tasks.',
//         icon: 'ic_stat_assignment',
//       ),
//     );
//     flutterLocalNotificationsPlugin
//         // .show(
//         //   id,
//         //   title,
//         //   body,
//         //   notificationDetails,
//         // );
//         .zonedSchedule(
//       id,
//       title,
//       body,
//       tz.TZDateTime.from(dateTime, tz.local),
//       notificationDetails,
//       androidAllowWhileIdle: true,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//     );
//   } catch (e) {
//     debugPrint('ERROR: $e');
//   }
// }
