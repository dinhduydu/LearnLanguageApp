import 'package:flutter/material.dart';
import '../../domain/folder.dart';
import '../widgets/folder_tile.dart';
import '../widgets/create_folder_dialog.dart';
import '../widgets/create_file_dialog.dart';

class FolderDetailPage extends StatefulWidget {
  final Folder folder;

  const FolderDetailPage({super.key, required this.folder});

  @override
  State<FolderDetailPage> createState() => _FolderDetailPageState();
}

class _FolderDetailPageState extends State<FolderDetailPage> {
  void _addSubFolder() async {
    final name = await showCreateFolderDialog(context);
    if (name != null && name.trim().isNotEmpty) {
      setState(() => widget.folder.subFolders.add(Folder(name: name.trim())));
    }
  }

  void _addFile() async {
    final file = await showCreateFileDialog(context);
    if (file != null) {
      setState(() => widget.folder.files.add(file));
    }
  }

  @override
  Widget build(BuildContext context) {
    final subFolders = widget.folder.subFolders;
    final files = widget.folder.files;

    return Scaffold(
      appBar: AppBar(title: Text(widget.folder.name)),
      body: ListView(
        children: [
          ...subFolders.map((f) => FolderTile(
                folder: f,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => FolderDetailPage(folder: f)),
                ),
              )),
          ...files.map((f) => ListTile(
                leading: const Icon(Icons.description),
                title: Text(f.title),
                subtitle: Text(f.content),
              )),
        ],
      ),
      floatingActionButton: PopupMenuButton<String>(
        icon: const Icon(Icons.add),
        onSelected: (value) {
          if (value == 'folder') _addSubFolder();
          if (value == 'file') _addFile();
        },
        itemBuilder: (context) => [
          const PopupMenuItem(value: 'folder', child: Text('New Folder')),
          const PopupMenuItem(value: 'file', child: Text('New File')),
        ],
      ),
    );
  }
}
