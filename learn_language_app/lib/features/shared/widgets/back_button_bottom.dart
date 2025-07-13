import 'package:flutter/material.dart';

class BackButtonBottom extends StatelessWidget {
  const BackButtonBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FloatingActionButton.extended(
          onPressed: () => Navigator.pop(context),
          label: const Text('Back'),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
    );
  }
}
