import 'package:flutter/material.dart';

/** Represents a single vocabulary word and its meaning */
class VocabularyItemTile extends StatelessWidget {
  final int index;
  final String word;
  final String meaning;

  const VocabularyItemTile({
    super.key,
    required this.index,
    required this.word,
    required this.meaning,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Text('${index + 1}')),
      title: Text(word),
      subtitle: Text(meaning),
    );
  }
}
