import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:user_app/features/search/data/models/places_model.dart';
import 'package:user_app/features/search/domain/usecase/search_places_usecase.dart';

part '../search/search_places_state.dart';

class SearchPlacesCubit extends Cubit<SearchPlacesState> {
  final SearchPlacesUseCase _searchPlacesUseCase;

  SearchPlacesCubit({
    required SearchPlacesUseCase searchPlacesUseCase,
  })  : _searchPlacesUseCase = searchPlacesUseCase,
        super(SearchPlacesInitial());

  Future<PlacesModel> searchPlacesTypeAhead({required String input}) async {
    return await _searchPlacesUseCase(input: input);
  }

  Future<void> searchPlaces({required String input}) async {
    try {
      var placesModel = await _searchPlacesUseCase(input: input);
      emit(SearchPlacesSuccess(placesModel));
    } catch (err) {
      emit(SearchPlacesFailed(err.toString()));
    }
  }

  clearState() {
    emit(SearchPlacesInitial());
  }
}
