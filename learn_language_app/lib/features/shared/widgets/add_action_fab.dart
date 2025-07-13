import 'package:flutter/material.dart';

class AddActionFab extends StatelessWidget {
  final VoidCallback onCreateFolder;
  final VoidCallback onCreateFile;

  const AddActionFab({
    super.key,
    required this.onCreateFolder,
    required this.onCreateFile,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showMenu(
          context: context,
          position: const RelativeRect.fromLTRB(1000, 600, 16, 16),
          items: [
            PopupMenuItem(
              child: const Text('Tạo Folder'),
              onTap: onCreateFolder,
            ),
            PopupMenuItem(
              child: const Text('Tạo File'),
              onTap: onCreateFile,
            ),
          ],
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
