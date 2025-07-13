import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:learn_language_app/features/shared/widgets/main_nav.dart';
import 'package:learn_language_app/features/folder/domain/folder.dart';
import 'package:learn_language_app/features/notion/data/notion_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double syncProgress = 0;
  FolderNode rootFolder = FolderNode(id: 'root', title: 'Learn Kanji', isFolder: true, children: []);

  Future<void> startSync() async {
    setState(() => syncProgress = 0.1);
    await Future.delayed(const Duration(milliseconds: 300));

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('notionToken') ?? '';
    final dbId = prefs.getString('notionDbId') ?? '';

    if (token.isEmpty || dbId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Chưa có Notion token hoặc database ID.")),
      );
      setState(() => syncProgress = 0);
      return;
    }

    final notion = NotionService(token: token, databaseId: dbId);

    try {
      final fetched = await notion.fetchNotionFolders();
      final Map<String, List<FolderNode>> grouped = {};

      for (var f in fetched) {
        final status = f.title.contains('Lesson') ? 'Qualified' : 'No Status';
        grouped.putIfAbsent(status, () => []).add(f);
      }

      final newRoot = FolderNode(
        id: 'root',
        title: 'Learn Kanji',
        isFolder: true,
        children: grouped.entries.map((e) {
          return FolderNode(
            id: e.key,
            title: e.key,
            isFolder: true,
            children: e.value,
          );
        }).toList(),
      );

      setState(() {
        syncProgress = 1.0;
        rootFolder = newRoot;
      });
    } catch (e) {
      debugPrint(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lỗi khi sync từ Notion.")),
      );
    }

    await Future.delayed(const Duration(milliseconds: 500));
    setState(() => syncProgress = 0);
  }

  /// Duyệt cây thư mục để lấy các file có reminder còn hiệu lực
  List<FolderNode> _getAllReminders(FolderNode node) {
    List<FolderNode> result = [];

    if (!node.isFolder &&
        node.reminderTime != null &&
        node.reminderTime!.isAfter(DateTime.now())) {
      result.add(node);
    }

    for (var child in node.children) {
      result.addAll(_getAllReminders(child));
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final reminders = _getAllReminders(rootFolder)
      ..sort((a, b) => a.reminderTime!.compareTo(b.reminderTime!));

    return Scaffold(
      drawer: const MainNav(),
      appBar: AppBar(title: const Text("HOME")),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                if (reminders.isNotEmpty) ...[
                  const Text("Reminders",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ...reminders.map((node) => Card(
                        child: ListTile(
                          leading: const Icon(Icons.alarm),
                          title: Text(node.title),
                          subtitle: Text(
                            'Lúc: ${DateFormat('dd/MM/yyyy HH:mm').format(node.reminderTime!)}',
                          ),
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Open file: ${node.title}')),
                            );
                          },
                        ),
                      )),
                  const SizedBox(height: 16),
                ],
                const Text("Folder Tree",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                _buildFolderTree(rootFolder),
                const SizedBox(height: 100),
              ],
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.1,
            minChildSize: 0.1,
            maxChildSize: 0.4,
            builder: (context, controller) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
                ),
                padding: const EdgeInsets.all(16),
                child: ListView(
                  controller: controller,
                  children: [
                    const Text("SYNC Progress",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(value: syncProgress),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: startSync,
                      child: const Text("Sync lại"),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFolderTree(FolderNode node, {int indent = 0}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: indent.toDouble()),
          child: ListTile(
            leading: Icon(node.isFolder ? Icons.folder : Icons.note),
            title: Text(node.title),
            onTap: () {
              if (!node.isFolder) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Open file: ${node.title}')),
                );
              }
            },
          ),
        ),
        if (node.isFolder)
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              children: node.children
                  .map((child) =>
                      _buildFolderTree(child, indent: indent + 16))
                  .toList(),
            ),
          )
      ],
    );
  }
}
