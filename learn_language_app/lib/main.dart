import 'package:flutter/material.dart';
import 'package:learn_language_app/features/home/presentation/pages/home_page.dart';
import 'package:learn_language_app/features/setting/presentation/pages/setting_page.dart';
import 'package:learn_language_app/features/home/presentation/pages/reminder_page.dart';

void main() {
  runApp(const LearnLanguageApp());
}

class LearnLanguageApp extends StatelessWidget {
  const LearnLanguageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learn Language',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/settings': (context) => const SettingPage(),
        '/reminder': (context) => const ReminderPage(), // Uncomment if ReminderPage is implemented
      },
    );
  }
}