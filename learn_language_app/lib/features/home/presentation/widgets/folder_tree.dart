import 'package:flutter/material.dart';
import 'package:learn_language_app/features/folder/domain/folder.dart';

class FolderTree extends StatelessWidget {
  final FolderNode node;
  final int indent;

  const FolderTree({super.key, required this.node, this.indent = 0});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: indent.toDouble()),
          child: ListTile(
            leading: Icon(node.isFolder ? Icons.folder : Icons.note),
            title: Text(node.title),
          ),
        ),
        if (node.isFolder)
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              children: node.children
                  .map((child) =>
                      FolderTree(node: child, indent: indent + 16))
                  .toList(),
            ),
          )
      ],
    );
  }
}
