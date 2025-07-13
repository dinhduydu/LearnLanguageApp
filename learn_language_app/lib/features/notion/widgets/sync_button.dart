import 'package:flutter/material.dart';

class SyncButton extends StatefulWidget {
  final VoidCallback onSync;
  final double progress; // 0.0 - 1.0

  const SyncButton({super.key, required this.onSync, required this.progress});

  @override
  State<SyncButton> createState() => _SyncButtonState();
}

class _SyncButtonState extends State<SyncButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: widget.onSync,
          icon: const Icon(Icons.sync),
          label: const Text("Sync"),
        ),
        if (widget.progress > 0 && widget.progress < 1)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: LinearProgressIndicator(value: widget.progress),
          ),
      ],
    );
  }
}