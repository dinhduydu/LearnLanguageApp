import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
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
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Đã lưu thông tin.")));
  }

  Widget _buildSecretField({
    required String label,
    required TextEditingController controller,
    required bool obscure,
    required VoidCallback onToggle,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(obscure ? Icons.visibility : Icons.visibility_off),
              onPressed: onToggle,
            ),
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: controller.text));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$label copied')));
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("🔐 USER", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildSecretField(
              label: "Notion API Token",
              controller: _tokenController,
              obscure: _obscureToken,
              onToggle: () => setState(() => _obscureToken = !_obscureToken),
            ),
            const SizedBox(height: 16),
            _buildSecretField(
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
            )
          ],
        ),
      ),
    );
  }
}