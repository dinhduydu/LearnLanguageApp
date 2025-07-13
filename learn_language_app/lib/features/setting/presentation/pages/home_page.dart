import 'package:flutter/material.dart';
import 'package:learn_language_app/features/folder/domain/folder.dart';

class HomePage extends StatefulWidget {
  final FolderNode rootFolder;

  const HomePage({super.key, required this.rootFolder});
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double syncProgress = 0;

  void startSync() async {
    for (final progress in [0.1, 0.4, 0.7, 1.0]) {
      await Future.delayed(const Duration(milliseconds: 400));
      setState(() => syncProgress = progress);
    }
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() => syncProgress = 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("HOME")),
      body: Stack(
        children: [
          Center(child: Text("Thư mục gốc: ${widget.rootFolder.title}")),
          DraggableScrollableSheet(
            initialChildSize: 0.1,
            minChildSize: 0.1,
            maxChildSize: 0.4,
            builder: (context, controller) => Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
              ),
              padding: const EdgeInsets.all(16),
              child: ListView(
                controller: controller,
                children: [
                  const Text("SYNC Progress", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(value: syncProgress),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: startSync,
                    child: const Text("Sync lại"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
