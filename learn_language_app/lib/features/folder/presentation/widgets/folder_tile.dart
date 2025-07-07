import 'package:flutter/material.dart';
import '../../domain/folder.dart';

class FolderTile extends StatelessWidget {
  final Folder folder;
  final VoidCallback? onTap;

  const FolderTile({super.key, required this.folder, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.folder),
      title: Text(folder.name),
      onTap: onTap,
    );
  }
}
