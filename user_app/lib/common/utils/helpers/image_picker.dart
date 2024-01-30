import 'package:image_picker/image_picker.dart';

/// Providing functions for picking images and videos using the image_picker plugin.
sealed class ImagePickerUtils {
  /// Picks an image from the gallery.
  ///
  /// ```
  /// Usage:
  ///   XFile? data = await pickImage(context);
  /// Returns:
  ///   A Future that returns selected XFile object, or null if an error occurred or image not picked.
  static Future<XFile?> pickImage() async {
    XFile? image;
    final ImagePicker picker = ImagePicker();
    image = await picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  /// Captures an image using the camera.
  ///
  /// ```
  /// Usage:
  ///   XFile? data = await captureImage(context);
  /// Returns:
  ///   A Future that returns the selected XFile object, or null if an error occurred or if no image is captured.
  static Future<XFile?> captureImage() async {
    XFile? image;
    final ImagePicker picker = ImagePicker();
    image = await picker.pickImage(source: ImageSource.camera);
    return image;
  }

  /// Picks a video from the gallery.
  ///
  /// ```
  /// Usage:
  ///   XFile? data = await pickVideo(context);
  /// Returns:
  ///   A Future that returns the selected XFile object, or null if an error occurred or if no image is selected.
  static Future<XFile?> pickVideo() async {
    XFile? video;
    final ImagePicker picker = ImagePicker();
    video = await picker.pickVideo(source: ImageSource.gallery);
    return video;
  }

  /// Captures a video using the camera.
  ///
  /// ```
  /// Usage:
  ///   XFile? data = await captureVideo(context);
  /// Returns:
  ///   A Future that returns the captured XFile object, or null if an error occurred or if no video is captured.
  static Future<XFile?> captureVideo() async {
    XFile? video;
    final ImagePicker picker = ImagePicker();
    video = await picker.pickVideo(source: ImageSource.camera);
    return video;
  }

  /// Picks multiple images from the gallery.
  ///
  /// ```
  /// Usage:
  ///   List<XFile> data = await pickMultiImage(context);
  /// Returns:
  ///   A Future that returns a List of the selected XFile objects, or null if no images were selected or an error occurred.
  static Future<List<XFile>> pickMultiImage() async {
    List<XFile> image;
    final ImagePicker picker = ImagePicker();
    image = await picker.pickMultiImage();
    return image;
  }

  /// Picks multiple images and videos from the gallery.
  ///
  /// ```
  /// Usage:
  ///   List<XFile> data = await pickMultiMedia(context);
  /// Returns:
  ///   A Future that returns a List of the selected XFile objects, or null if no media was selected or an error occurred.
  static Future<List<XFile>> pickMultiMedia() async {
    List<XFile> media;
    final ImagePicker picker = ImagePicker();
    media = await picker.pickMultipleMedia();
    return media;
  }
}
