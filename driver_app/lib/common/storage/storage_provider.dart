import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageProviderRemoteDataSource {
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static Future<String> uploadProfileImage(
      {required File file, Function(bool isUploading)? onComplete}) async {
    onComplete!(true);

    final ref =
        _storage.ref().child("images/${DateTime.now().millisecondsSinceEpoch}");

    final uploadTask = ref.putData(
      await file.readAsBytes(),
      SettableMetadata(contentType: 'image/png'),
    );

    final imageUrl =
        (await uploadTask.whenComplete(() {})).ref.getDownloadURL();
    onComplete(false);
    return await imageUrl;
  }
}
