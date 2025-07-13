import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learn_language_app/features/folder/domain/folder.dart';

class RemindersList extends StatelessWidget {
  final FolderNode rootFolder;

  const RemindersList({super.key, required this.rootFolder});

  List<FolderNode> _getAllReminders(FolderNode node) {
    List<FolderNode> result = [];

    if (!node.isFolder &&
        node.reminderTime != null &&
        node.reminderTime!.isAfter(DateTime.now())) {
      result.add(node);
    }

    for (var child in node.children) {
      result.addAll(_getAllReminders(child));
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final reminders = _getAllReminders(rootFolder)
      ..sort((a, b) => a.reminderTime!.compareTo(b.reminderTime!));

    if (reminders.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Reminders",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...reminders.map((node) => Card(
              child: ListTile(
                leading: const Icon(Icons.alarm),
                title: Text(node.title),
                subtitle: Text(
                  'Lúc: ${DateFormat('dd/MM/yyyy HH:mm').format(node.reminderTime!)}',
                ),
              ),
            )),
      ],
    );
  }
}
