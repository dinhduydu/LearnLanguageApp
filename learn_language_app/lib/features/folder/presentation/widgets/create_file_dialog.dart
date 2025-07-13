import 'package:flutter/material.dart';
import '../../domain/folder.dart';
import 'package:intl/intl.dart'; // để định dạng ngày giờ hiển thị

Future<FileNote?> showCreateFileDialog(BuildContext context) {
  String title = '';
  String content = '';
  DateTime? reminderTime;

  return showDialog<FileNote>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Create new file'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (val) => title = val,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  onChanged: (val) => content = val,
                  decoration: const InputDecoration(labelText: 'Content'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      final pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        final fullDateTime = DateTime(
                          pickedDate.year,
                          pickedDate.month,
                          pickedDate.day,
                          pickedTime.hour,
                          pickedTime.minute,
                        );
                        setState(() {
                          reminderTime = fullDateTime;
                        });
                      }
                    }
                  },
                  child: Text(reminderTime == null
                      ? 'Set Reminder'
                      : 'Reminder: ${DateFormat('dd/MM/yyyy HH:mm').format(reminderTime!)}'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    FileNote(
                      title: title,
                      content: content,
                      reminderTime: reminderTime,
                    ),
                  );
                },
                child: const Text('Create'),
              ),
            ],
          );
        },
      );
    },
  );
}
