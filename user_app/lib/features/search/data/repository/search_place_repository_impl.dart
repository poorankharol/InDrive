import 'dart:io';

import 'package:dio/dio.dart';
import 'package:user_app/common/networking/repository/base_repository.dart';
import 'package:user_app/features/search/data/datasource/remote/search_places_service.dart';
import 'package:user_app/features/search/data/models/place_details_model.dart';
import 'package:user_app/features/search/data/models/places_model.dart';

import '../../../../common/networking/utils/internet_connectivity.dart';
import '../../domain/repository/search_place_repository.dart';

class SearchPlaceRepositoryImpl extends BaseRepository
    implements SearchPlaceRepository {
  final SearchPlacesService searchPlacesService;

  SearchPlaceRepositoryImpl({required this.searchPlacesService});

  @override
  Future<PlacesModel> searchPlace(String input) async {
    // final request = _searchPlacesService.searchPlaces(input);
    // return execute(request: request);
    try {
      if (!await Internet.isAvailable) {
        throw Exception("No internet connection");
      }

      final httpResponse = await searchPlacesService.searchPlaces(input);

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

  @override
  Future<PlaceDetailsModel> searchPlaceDetails(String placeId) async {
    print(placeId);
    try {
      if (!await Internet.isAvailable) {
        throw Exception("No internet connection");
      }

      final httpResponse = await searchPlacesService.searchPlaceDetails(placeId);

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
