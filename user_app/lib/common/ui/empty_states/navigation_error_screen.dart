import 'package:flutter/material.dart';

import '../../constants/error_messages.dart';
import '../../extensions/build_context_extensions.dart';

class NavigationErrorScreen extends StatelessWidget {
  const NavigationErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child: Text(
          ErrorMessages.navigationErrorMessage,
          style: context.textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
