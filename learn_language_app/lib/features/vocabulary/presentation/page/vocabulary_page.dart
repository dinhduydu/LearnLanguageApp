import 'package:flutter/material.dart';
import '../widget/vocabulary_sheet.dart';

/** Main screen for displaying vocabulary */
class VocabularyPage extends StatelessWidget {
  const VocabularyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vocabulary')),
      body: Stack(
        children: const [
          Center(
            child: Text(
              'Swipe up to view vocabulary',
              style: TextStyle(fontSize: 18),
            ),
          ),
          VocabularySheet(), // Move scrollable sheet into separate widget
        ],
      ),
    );
  }
}
