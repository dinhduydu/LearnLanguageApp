import 'package:flutter/material.dart';

class CreateFolderFab extends StatelessWidget {
  final VoidCallback onCreateFolder;
  final VoidCallback onCreateFile;

  const CreateFolderFab({
    super.key,
    required this.onCreateFolder,
    required this.onCreateFile,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          builder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.folder),
                title: const Text('Tạo Folder'),
                onTap: () {
                  Navigator.pop(context);
                  onCreateFolder();
                },
              ),
              ListTile(
                leading: const Icon(Icons.note_add),
                title: const Text('Tạo File'),
                onTap: () {
                  Navigator.pop(context);
                  onCreateFile();
                },
              ),
            ],
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
