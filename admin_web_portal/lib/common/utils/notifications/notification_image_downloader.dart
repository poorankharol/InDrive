import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

/// Class for handling image downloads for notifications
class NotificationImageDownloader {
  /// Downloads an image from the specified URL and saves it to a file.
  ///
  ///   [url]: The URL of the image to download.
  ///
  ///   [fileName]: The name to use for the saved image file.
  ///
  /// Returns:
  ///   A Future string containing the path to the saved image file.
  static Future<String> downloadAndSaveFile(String url, String fileName) async {
    Dio dio = Dio();
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final Response response = await dio.get(url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
        ));
    final File file = File(filePath);
    await file.writeAsBytes(response.data);
    return filePath;
  }

  static Future<String> base64encodedImage(String url, String fileName) async {
    Dio dio = Dio();
    final Response response = await dio.get(url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
        ));
    final String base64Data = base64Encode(response.data);
    return base64Data;
  }
}
