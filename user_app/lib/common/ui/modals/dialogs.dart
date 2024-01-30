import 'package:flutter/material.dart';

import '../../extensions/build_context_extensions.dart';

sealed class AppDialogs {
  ///Displays AlertDialog with [title],[description] and action button.
  static void showAlertDialog({
    required BuildContext context,
    required String title,
    required String description,
    required String actionButtonLabel,
    bool isDismissible = true,
    Function()? onActionButtonPressed,
  }) {
    showDialog(
      context: context,
      barrierDismissible: isDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsPadding: const EdgeInsets.all(10),
          title: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          content: ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 100,
            ),
            child: SingleChildScrollView(
              child: Text(
                description,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.navigator.pop();
                onActionButtonPressed?.call();
              },
              child: Text(actionButtonLabel),
            ),
          ],
        );
      },
    );
  }
}
