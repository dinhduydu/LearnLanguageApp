import 'package:flutter/material.dart';
import '../../data/vocabulary_list.dart';
import 'vocabulary_item_tile.dart';

/** Scrollable draggable sheet displaying vocabulary items */
class VocabularySheet extends StatelessWidget {
  const VocabularySheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.2,
      minChildSize: 0.2,
      maxChildSize: 1,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            boxShadow: [BoxShadow(blurRadius: 8, color: Colors.black26)],
          ),
          child: ListView.builder(
            controller: scrollController,
            itemCount: vocabularyList.length,
            itemBuilder: (context, index) {
              final item = vocabularyList[index];
              return VocabularyItemTile(
                index: index,
                word: item['word']!,
                meaning: item['meaning']!,
              );
            },
          ),
        );
      },
    );
  }
}
