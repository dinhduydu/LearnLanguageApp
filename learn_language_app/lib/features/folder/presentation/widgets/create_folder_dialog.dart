import 'package:flutter/material.dart';

Future<String?> showCreateFolderDialog(BuildContext context) {
  String folderName = '';
  return showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Create new folder'),
      content: TextField(
        onChanged: (val) => folderName = val,
        autofocus: true,
        decoration: const InputDecoration(hintText: 'Folder name'),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        TextButton(onPressed: () => Navigator.pop(context, folderName), child: const Text('Create')),
      ],
    ),
  );
}
