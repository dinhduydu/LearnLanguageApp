import 'package:flutter/material.dart';
import '../../../../learnjp/lib/feature/data/vocabulary_list.dart';

class VocabularyPage extends StatelessWidget {
  const VocabularyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Vocabulary'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: vocabularyList.length,
        itemBuilder: (context, index) {
          final item = vocabularyList[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text('${index + 1}'),
            ),
            title: Text(item['word'] ?? ''),
            subtitle: Text(item['meaning'] ?? ''),
          );
        },
      ),
    );
  }
}
