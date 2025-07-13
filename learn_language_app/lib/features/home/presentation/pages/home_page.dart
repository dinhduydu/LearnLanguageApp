import 'package:flutter/material.dart';
import 'package:learn_language_app/features/folder/domain/folder.dart';
import 'package:learn_language_app/features/home/presentation/widgets/folder_tree.dart';
import 'package:learn_language_app/features/home/presentation/widgets/reminders_list.dart';
import 'package:learn_language_app/features/home/presentation/widgets/sync_sheet.dart';
import 'package:learn_language_app/features/shared/widgets/main_nav.dart';
import 'package:learn_language_app/features/shared/widgets/create_folder_fab.dart';
import 'package:learn_language_app/features/folder/presentation/widgets/create_folder_dialog.dart';
import 'package:learn_language_app/features/folder/presentation/widgets/create_file_dialog.dart';

class HomePage extends StatefulWidget {
  final FolderNode rootFolder;

  const HomePage({super.key, required this.rootFolder});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FolderNode rootFolder;

  @override
  void initState() {
    super.initState();
    rootFolder = widget.rootFolder;
  }

  void updateRootFolder(FolderNode newRoot) {
    setState(() {
      rootFolder = newRoot;
    });
  }

  /// Thêm folder mới vào root
  Future<void> _createFolder() async {
    final name = await showCreateFolderDialog(context);
    if (name != null && name.isNotEmpty) {
      setState(() {
        rootFolder.children.add(
          FolderNode(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            title: name,
            isFolder: true,
            children: [],
          ),
        );
      });
    }
  }

  /// Thêm file mới vào root
  Future<void> _createFile() async {
    final file = await showCreateFileDialog(context);
    if (file != null) {
      setState(() {
        rootFolder.children.add(
          FolderNode(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            title: file.title,
            content: file.content,
            isFolder: false,
            reminderTime: file.reminderTime,
            children: [],
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainNav(),
      appBar: AppBar(title: const Text("HOME")),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                RemindersList(rootFolder: rootFolder),
                const SizedBox(height: 16),
                const Text("Folder Tree",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                FolderTree(node: rootFolder),
                const SizedBox(height: 100),
              ],
            ),
          ),
          SyncSheet(
            rootFolder: rootFolder,
            onSyncComplete: updateRootFolder,
          ),
        ],
      ),
      floatingActionButton: CreateFolderFab(
        onCreateFolder: _createFolder,
        onCreateFile: _createFile,
      ),
    );
  }
}
