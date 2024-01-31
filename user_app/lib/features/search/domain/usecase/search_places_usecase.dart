import 'package:user_app/features/search/data/models/places_model.dart';
import 'package:user_app/features/search/domain/repository/search_place_repository.dart';

class SearchPlacesUseCase {
  final SearchPlaceRepository searchPlaceRepository;

  SearchPlacesUseCase({required this.searchPlaceRepository});

  Future<PlacesModel> call({required String input}) async {
    try {
      PlacesModel placeModel = await searchPlaceRepository.searchPlace(input);
      return placeModel;
    } catch (error) {
      throw Exception(error);
    }
  }
}
