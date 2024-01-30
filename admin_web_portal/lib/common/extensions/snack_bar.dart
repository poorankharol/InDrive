import 'package:flutter/material.dart';

import '../ui/modals/snackbar.dart';

extension SnackBarExtension on BuildContext {
  void showSnackbar(String message, {bool isError = false}) =>
      SnackbarManager.showSnackbar(
        context: this,
        message: message,
        isError: isError,
      );

  void showSnackbarWithAction({
    required String message,
    required String label,
    required Function() onPressed,
  }) =>
      SnackbarManager.showSnackbarWithAction(
        context: this,
        message: message,
        label: label,
        onPressed: onPressed,
      );
}
