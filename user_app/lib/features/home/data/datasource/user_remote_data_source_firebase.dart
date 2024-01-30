import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:user_app/features/home/data/datasource/user_remote_data_source.dart';
import 'package:user_app/features/home/data/models/user_model.dart';

class UserRemoteDataSourceFirebase implements UserRemoteDataSource {
  UserRemoteDataSourceFirebase({
    FirebaseDatabase? firebaseDatabase,
    FirebaseAuth? firebaseAuth,
  })  : _firebaseDatabase = firebaseDatabase ?? FirebaseDatabase.instance,
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseDatabase _firebaseDatabase;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<UserModel?> getUser() async {
    DatabaseReference driversRef = _firebaseDatabase
        .ref()
        .child("users")
        .child(_firebaseAuth.currentUser!.uid);
    DataSnapshot snapshot = await driversRef.get();
    if (snapshot.exists) {
      print(snapshot.value);
      final data = Map<String, dynamic>.from(snapshot.value as Map);
      UserModel userModel = UserModel.fromJson(data);
      return userModel;
    } else {
      return null; // Return an null if no data exists
    }
  }
}
