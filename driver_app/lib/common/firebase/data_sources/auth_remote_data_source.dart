
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Stream<User?> get user;

  Future<User> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();

  // Cloud Storage
  Future<String> uploadImageToStorage(File? file, String childName);
}
