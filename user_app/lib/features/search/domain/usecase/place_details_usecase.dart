import 'package:user_app/features/search/data/models/place_details_model.dart';
import 'package:user_app/features/search/domain/repository/search_place_repository.dart';

class PlaceDetailsUseCase {
  final SearchPlaceRepository searchPlaceRepository;

  PlaceDetailsUseCase({required this.searchPlaceRepository});

  Future<PlaceDetailsModel> call({required String placeId}) async {
    try {
      PlaceDetailsModel placeDetailsModel =
          await searchPlaceRepository.searchPlaceDetails(placeId);
      return placeDetailsModel;
    } catch (error) {
      throw Exception(error);
    }
  }
}
