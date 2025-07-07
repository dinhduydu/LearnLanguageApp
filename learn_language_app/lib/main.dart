import 'package:flutter/material.dart';
import 'features/vocabulary/presentation/page/vocabulary_page.dart';

/** Entry point of the app */
void main() {
  runApp(const MyApp());
}

/** Root widget for the app */
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vocabulary App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const VocabularyPage(), // Start at vocabulary screen
    );
  }
}
