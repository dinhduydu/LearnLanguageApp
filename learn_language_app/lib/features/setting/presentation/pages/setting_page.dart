import 'package:flutter/material.dart';
import 'package:learn_language_app/features/shared/widgets/back_button_bottom.dart';
import 'package:learn_language_app/features/setting/presentation/widgets/setting_form.dart';
import 'package:learn_language_app/features/folder/domain/folder.dart';

class SettingPage extends StatelessWidget {
  final FolderNode rootFolder;

  const SettingPage({super.key, required this.rootFolder});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: _SettingBody(),
      ),
      floatingActionButton: const BackButtonBottom(),
    );
  }
}

class _SettingBody extends StatelessWidget {
  const _SettingBody();

  @override
  Widget build(BuildContext context) {
    final rootFolder = (ModalRoute.of(context)?.settings.arguments as FolderNode?) ??
        FolderNode(id: 'root', title: 'Learn Kanji', isFolder: true, children: []);

    return SettingForm(rootFolder: rootFolder);
  }
}
