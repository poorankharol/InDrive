import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../exception/custom_auth_exception.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceFirebase implements AuthRemoteDataSource {
  AuthRemoteDataSourceFirebase({
    firebase_auth.FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final firebase_auth.FirebaseAuth _firebaseAuth;

  @override
  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      if (firebaseUser == null) {
        return null;
      }
      return firebaseUser;
    });
  }

  @override
  Future<User> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      firebase_auth.UserCredential credential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw Exception('Sign up failed: The user is null after sign up.');
      }

      return credential.user!;
    } on FirebaseAuthException catch (e) {
      final errorMessage = _handleFirebaseAuthException(e);
      throw CustomAuthException(errorMessage);
    } catch (error) {
      final errorMessage = 'Sign in failed: $error';
      // Optionally log the error for debugging or reporting:
      if (kDebugMode) {
        print(errorMessage);
      }
      throw CustomAuthException(errorMessage);
    }
  }

  @override
  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw StateError('Sign in failed: The user is null after sign in.');
      }

      return credential.user!;
    } on FirebaseAuthException catch (e) {
      final errorMessage = _handleFirebaseAuthException(e);
      throw CustomAuthException(errorMessage);
    } catch (error) {
      final errorMessage = 'Sign in failed: $error';
      // Optionally log the error for debugging or reporting:
      if (kDebugMode) {
        print(errorMessage);
      }
      throw CustomAuthException(errorMessage);
    }
  }

  String _handleFirebaseAuthException(FirebaseAuthException e) {
    print(e.code);
    switch (e.code) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided for that user.';
      case 'invalid-credential':
        return 'The supplied auth credential is invalid';
      default:
        return 'An unknown error occurred.';
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (error) {
      throw Exception('Sign out failed: $error');
    }
  }
}
