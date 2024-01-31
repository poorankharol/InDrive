import 'package:flutter/material.dart';
import 'package:user_app/common/ui/modals/spacing.dart';

class Loader extends StatelessWidget {
  const Loader({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          gapW4,
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
          gapW4,
          message.isEmpty ? const SizedBox.shrink() : Text(message)
        ],
      ),
    );
  }
}
