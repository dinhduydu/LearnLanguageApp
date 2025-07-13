import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:learn_language_app/features/notion/data/notion_service.dart';
import 'package:learn_language_app/features/folder/domain/folder.dart';

class SyncSheet extends StatefulWidget {
  final FolderNode rootFolder;
  final Function(FolderNode) onSyncComplete;

  const SyncSheet({super.key, required this.rootFolder, required this.onSyncComplete});

  @override
  State<SyncSheet> createState() => _SyncSheetState();
}

class _SyncSheetState extends State<SyncSheet> {
  double progress = 0;

  Future<void> startSync() async {
    setState(() => progress = 0.1);
    await Future.delayed(const Duration(milliseconds: 300));

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('notionToken') ?? '';
    final dbId = prefs.getString('notionDbId') ?? '';

    if (token.isEmpty || dbId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Chưa có Notion token hoặc database ID.")),
      );
      setState(() => progress = 0);
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

      widget.onSyncComplete(newRoot);
    } catch (e) {
      debugPrint(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lỗi khi sync từ Notion.")),
      );
    }

    await Future.delayed(const Duration(milliseconds: 500));
    setState(() => progress = 0);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              LinearProgressIndicator(value: progress),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: startSync,
                child: const Text("Sync lại"),
              ),
            ],
          ),
        );
      },
    );
  }
}
