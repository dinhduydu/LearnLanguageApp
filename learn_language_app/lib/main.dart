import 'package:flutter/material.dart';
import 'package:learn_language_app/features/home/presentation/pages/home_page.dart';
import 'package:learn_language_app/features/setting/presentation/pages/setting_page.dart';
import 'package:learn_language_app/features/reminder/presentation/pages/reminder_page.dart';
import 'package:learn_language_app/features/folder/domain/folder.dart';
import 'package:learn_language_app/features/home/presentation/pages/home_page.dart';

void main() {
  runApp(LearnLanguageApp());
}

class LearnLanguageApp extends StatelessWidget {
  LearnLanguageApp({super.key});

  // Khởi tạo rootFolder chung
  final FolderNode rootFolder = FolderNode(
    id: 'root',
    title: 'Learn Kanji',
    isFolder: true,
    children: [],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learn Language',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color.fromARGB(255, 77, 0, 150),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(rootFolder: rootFolder),
        '/settings': (context) => SettingPage(rootFolder: rootFolder),
        '/reminder': (context) => const ReminderPage(),
      },
    );
  }
}
