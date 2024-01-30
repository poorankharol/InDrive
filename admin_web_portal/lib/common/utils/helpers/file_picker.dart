import 'dart:io';

import 'package:file_picker/file_picker.dart';

/// Providing functions for picking files using the file_picker plugin.
sealed class FilePickerUtils {
  /// Picks a single file using the platform's file picker.
  /// ```dart
  /// Usage:
  ///   File? data = await pickSingleFile(context);
  /// Returns:
  ///   A Future that returns the selected File object, or null if no file was selected.
  static Future<File?> pickSingleFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        return File(result.files.single.path!);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  /// Picks multiple files using the platform's file picker.
  /// ```dart
  /// Usage:
  ///   List<File?> data = await pickMultipleFile(context);
  /// Returns:
  ///   A Future that returns a List of the selected File objects, or an empty List if no files were selected.
  static Future<List<File>?> pickMultipleFile() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(allowMultiple: true);
      if (result != null) {
        return result.paths.map((path) => File(path!)).toList();
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
