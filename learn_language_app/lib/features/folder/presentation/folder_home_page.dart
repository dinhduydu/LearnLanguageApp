import 'package:flutter/material.dart';
import '../../domain/folder.dart';

class FolderHomePage extends StatefulWidget {
  const FolderHomePage({super.key});

  @override
  State<FolderHomePage> createState() => _FolderHomePageState();
}

class _FolderHomePageState extends State<FolderHomePage> {
  final List<Folder> folders = [];

  void _createNewFolder() async {
    final name = await showDialog<String>(
      context: context,
      builder: (context) {
        String folderName = '';
        return AlertDialog(
          title: const Text('Create new folder'),
          content: TextField(
            autofocus: true,
            onChanged: (value) => folderName = value,
            decoration: const InputDecoration(hintText: 'Enter folder name'),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            TextButton(onPressed: () => Navigator.pop(context, folderName), child: const Text('Create')),
          ],
        );
      },
    );

    if (name != null && name.trim().isNotEmpty) {
      setState(() {
        folders.add(Folder(name: name.trim()));
      });
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
          return ListTile(
            leading: const Icon(Icons.folder),
            title: Text(folder.name),
            onTap: () {
              // TODO: navigate to folder details
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewFolder,
        child: const Icon(Icons.add),
      ),
    );
  }
}
