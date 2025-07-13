import 'package:flutter/material.dart';

Future<String?> showCreateFolderDialog(BuildContext context) async {
  String folderName = '';

  return showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Tạo Folder mới'),
      content: TextField(
        autofocus: true,
        onChanged: (val) => folderName = val,
        decoration: const InputDecoration(hintText: 'Nhập tên folder'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Huỷ'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, folderName),
          child: const Text('Tạo'),
        ),
      ],
    ),
  );
}
