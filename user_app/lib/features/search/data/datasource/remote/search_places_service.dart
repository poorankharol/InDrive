import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../common/networking/constants/endpoints.dart';
import '../../models/place_details_model.dart';
import '../../models/places_model.dart';

part 'search_places_service.g.dart';

@RestApi()
abstract class SearchPlacesService {
  factory SearchPlacesService(Dio dio, {String baseUrl}) = _SearchPlacesService;

  @GET(Endpoint.searchPlaces)
  Future<HttpResponse<PlacesModel>> searchPlaces(
      @Path("input") String input);

  @GET(Endpoint.searchPlaceDetails)
  Future<HttpResponse<PlaceDetailsModel>> searchPlaceDetails(
      @Path("place_id") String placeId);
}
