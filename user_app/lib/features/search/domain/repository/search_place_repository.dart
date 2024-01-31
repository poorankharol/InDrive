import 'package:user_app/features/search/data/models/place_details_model.dart';
import 'package:user_app/features/search/data/models/places_model.dart';

abstract class SearchPlaceRepository {
  Future<PlacesModel> searchPlace(String input);
  Future<PlaceDetailsModel> searchPlaceDetails(String placeId);
}
