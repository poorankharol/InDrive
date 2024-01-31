import 'dart:io';
import 'package:dio/dio.dart';
import 'package:user_app/features/home/data/datasource/remote/directions_service.dart';
import 'package:user_app/features/home/data/datasource/user_remote_data_source.dart';
import 'package:user_app/features/home/data/models/directions_model.dart';
import 'package:user_app/features/home/data/models/user_model.dart';
import 'package:user_app/features/home/domain/repository/home_repository.dart';

import '../../../../common/firebase/data_sources/auth_remote_data_source.dart';
import '../../../../common/networking/utils/internet_connectivity.dart';

class HomeRepositoryImpl implements HomeRepository {
  final AuthRemoteDataSource remoteDataSource;
  final UserRemoteDataSource userRemoteDataSource;
  final DirectionsService directionsService;

  const HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.userRemoteDataSource,
    required this.directionsService,
  });

  @override
  Future<UserModel?> getUser() async {
    return await userRemoteDataSource.getUser();
  }

  @override
  Future<void> signOut() async {
    await remoteDataSource.signOut();
  }

  @override
  Future<DirectionsModel> getDirections(
      String origin, String destination) async {
    try {
      if (!await Internet.isAvailable) {
        throw Exception("No internet connection");
      }

      final httpResponse =
          await directionsService.getDirections(origin, destination);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return httpResponse.data;
      } else {
        throw DioException(
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
        );
      }
    } on DioException catch (_) {
      rethrow;
    }
  }
}
