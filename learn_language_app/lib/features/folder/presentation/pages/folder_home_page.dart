import 'package:flutter/material.dart';
import '../../domain/folder.dart';
import 'folder_detail_page.dart';
import '../widgets/folder_tile.dart';
import '../widgets/create_folder_dialog.dart';

class FolderHomePage extends StatefulWidget {
  const FolderHomePage({super.key});

  @override
  State<FolderHomePage> createState() => _FolderHomePageState();
}

class _FolderHomePageState extends State<FolderHomePage> {
  final List<Folder> folders = [];

  void _createRootFolder() async {
    final name = await showCreateFolderDialog(context);
    if (name != null && name.trim().isNotEmpty) {
      setState(() => folders.add(Folder(name: name.trim())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Folders')),
      body: ListView.builder(
        itemCount: folders.length,
        itemBuilder: (context, index) {
          final folder = folders[index];
          return FolderTile(
            folder: folder,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => FolderDetailPage(folder: folder)),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createRootFolder,
        child: const Icon(Icons.create_new_folder),
      ),
    );
  }
}
