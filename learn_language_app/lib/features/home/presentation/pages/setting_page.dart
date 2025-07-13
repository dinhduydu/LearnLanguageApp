import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool showToken = false;
  bool showDbId = false;

  final TextEditingController _tokenController = TextEditingController();
  final TextEditingController _dbController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("USER", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildSecureField("Notion API Token", _tokenController, showToken, () {
              setState(() => showToken = !showToken);
            }),
            const SizedBox(height: 12),
            _buildSecureField("Database ID", _dbController, showDbId, () {
              setState(() => showDbId = !showDbId);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSecureField(String label, TextEditingController controller, bool showText, VoidCallback onToggle) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            obscureText: !showText,
            decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
          ),
        ),
        IconButton(
          icon: Icon(showText ? Icons.visibility_off : Icons.visibility),
          onPressed: onToggle,
        ),
        IconButton(
          icon: const Icon(Icons.copy),
          onPressed: () {
            final data = controller.text;
            if (data.isNotEmpty) {
              Clipboard.setData(ClipboardData(text: data));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Đã sao chép")),
              );
            }
          },
        ),
      ],
    );
  }
}