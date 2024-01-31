import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:user_app/features/search/domain/usecase/place_details_usecase.dart';

import '../../../data/models/place_details_model.dart';

part 'place_details_state.dart';

class PlaceDetailsCubit extends Cubit<PlaceDetailsState> {
  final PlaceDetailsUseCase _placeDetailsUseCase;

  PlaceDetailsCubit({
    required PlaceDetailsUseCase placeDetailsUseCase,
  })  : _placeDetailsUseCase = placeDetailsUseCase,
        super(PlaceDetailsInitial());

  Future<void> searchPlaces({required String placeId}) async {
    emit(PlaceDetailsLoading());
    try {
      var placesModel = await _placeDetailsUseCase(placeId: placeId);
      emit(PlaceDetailsSuccess(placesModel));
    } catch (err) {
      emit(PlaceDetailsFailed(err.toString()));
    }
  }


}
