import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FileNote {
  final String title;
  final String content;
  final DateTime? reminderTime;

  FileNote({
    required this.title,
    required this.content,
    this.reminderTime,
  });
}

Future<FileNote?> showCreateFileDialog(BuildContext context) {
  String title = '';
  String content = '';
  DateTime? reminderTime;

  return showDialog<FileNote>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Tạo File mới'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  onChanged: (val) => title = val,
                  decoration: const InputDecoration(labelText: 'Tiêu đề'),
                ),
                TextField(
                  onChanged: (val) => content = val,
                  decoration: const InputDecoration(labelText: 'Nội dung'),
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
                        setState(() {
                          reminderTime = DateTime(
                            pickedDate.year,
                            pickedDate.month,
                            pickedDate.day,
                            pickedTime.hour,
                            pickedTime.minute,
                          );
                        });
                      }
                    }
                  },
                  child: Text(reminderTime == null
                      ? 'Đặt nhắc nhở'
                      : 'Nhắc lúc: ${DateFormat('dd/MM/yyyy HH:mm').format(reminderTime!)}'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Huỷ'),
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
              child: const Text('Tạo'),
            ),
          ],
        ),
      );
    },
  );
}
