import 'package:flutter/material.dart';

import '../../extensions/build_context_extensions.dart';

sealed class SnackbarManager {
  ///Displays Snackbar with [message].<br/>
  ///If [isError] is set to true, then snackbar will be displayed with red background color.
  static void showSnackbar({
    required BuildContext context,
    required String message,
    bool isError = false,
  }) {
    context.scaffoldMessenger
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? Colors.red : context.theme.primaryColor,
        ),
      );
  }

  ///Displays Snackbar with [message] and [label] with action.<br/>
  static void showSnackbarWithAction({
    required BuildContext context,
    required String message,
    required String label,
    required Function() onPressed,
  }) {
    context.scaffoldMessenger
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          action: SnackBarAction(
            label: label,
            onPressed: onPressed,
          ),
        ),
      );
  }
}
