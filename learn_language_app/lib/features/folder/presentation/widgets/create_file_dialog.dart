import 'package:flutter/material.dart';
import '../../domain/folder.dart';

Future<FileNote?> showCreateFileDialog(BuildContext context) {
  String title = '';
  String content = '';

  return showDialog<FileNote>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Create new file'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(onChanged: (val) => title = val, decoration: const InputDecoration(labelText: 'Title')),
          TextField(onChanged: (val) => content = val, decoration: const InputDecoration(labelText: 'Content')),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        TextButton(
          onPressed: () => Navigator.pop(context, FileNote(title: title, content: content)),
          child: const Text('Create'),
        ),
      ],
    ),
  );
}
