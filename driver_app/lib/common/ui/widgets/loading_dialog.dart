import 'package:flutter/material.dart';
import 'package:driver_app/common/ui/modals/spacing.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: Colors.black87,
      child: Container(
        margin: const EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              gapW4,
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
              gapW4,
              Text(message)
            ],
          ),
        ),
      ),
    );
  }
}
