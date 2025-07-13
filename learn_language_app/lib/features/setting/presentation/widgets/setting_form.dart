import 'package:flutter/material.dart';
import 'package:learn_language_app/features/folder/domain/folder.dart';
import 'package:learn_language_app/features/folder/domain/note_file.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:learn_language_app/features/setting/presentation/widgets/secret_field.dart';

class SettingForm extends StatefulWidget {
  final FolderNode rootFolder;

  const SettingForm({super.key, required this.rootFolder});

  @override
  State<SettingForm> createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final _tokenController = TextEditingController();
  final _databaseIdController = TextEditingController();

  bool _obscureToken = true;
  bool _obscureDb = true;

  @override
  void initState() {
    super.initState();
    _loadValues();
  }

  Future<void> _loadValues() async {
    final prefs = await SharedPreferences.getInstance();
    _tokenController.text = prefs.getString('notionToken') ?? '';
    _databaseIdController.text = prefs.getString('notionDbId') ?? '';
  }

  Future<void> _saveValues() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('notionToken', _tokenController.text.trim());
    await prefs.setString('notionDbId', _databaseIdController.text.trim());

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Đã lưu thông tin.")),
    );
  }

  Future<void> _createFolder() async {
    final name = await _showInputDialog('Tạo Folder', 'Tên Folder');
    if (name != null && name.isNotEmpty) {
      setState(() {
        widget.rootFolder.children.add(
          FolderNode(id: UniqueKey().toString(), title: name, isFolder: true, children: []),
        );
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Đã tạo folder "$name"')));
    }
  }

  Future<void> _createFile() async {
    final name = await _showInputDialog('Tạo File', 'Tên File');
    if (name != null && name.isNotEmpty) {
      setState(() {
        widget.rootFolder.children.add(
          FolderNode(
            id: UniqueKey().toString(),
            title: name,
            isFolder: false,
            children: [],
            content: '',
            notes: [NoteFile(id: UniqueKey().toString(), title: name, content: '')],
          ),
        );
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Đã tạo file "$name"')));
    }
  }

  Future<String?> _showInputDialog(String title, String label) async {
    String input = '';
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: TextField(
          autofocus: true,
          decoration: InputDecoration(labelText: label),
          onChanged: (val) => input = val,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Huỷ')),
          TextButton(onPressed: () => Navigator.pop(context, input), child: const Text('OK')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Text("🔐 USER", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        SecretField(
          label: "Notion API Token",
          controller: _tokenController,
          obscure: _obscureToken,
          onToggle: () => setState(() => _obscureToken = !_obscureToken),
        ),
        const SizedBox(height: 16),
        SecretField(
          label: "Notion Database ID",
          controller: _databaseIdController,
          obscure: _obscureDb,
          onToggle: () => setState(() => _obscureDb = !_obscureDb),
        ),
        const SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: _saveValues,
          icon: const Icon(Icons.save),
          label: const Text("Lưu thông tin"),
        ),
        const SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: _createFolder,
          icon: const Icon(Icons.create_new_folder),
          label: const Text("Tạo Folder"),
        ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: _createFile,
          icon: const Icon(Icons.note_add),
          label: const Text("Tạo File"),
        ),
      ],
    );
  }
}
