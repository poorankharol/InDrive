import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:user_app/features/home/data/models/directions_model.dart';
import 'package:user_app/features/home/domain/usecase/get_directions_usecase.dart';

part 'directions_state.dart';

class DirectionsCubit extends Cubit<DirectionsState> {
  final GetDirectionsUseCase _getDirectionsUseCase;

  DirectionsCubit({
    required GetDirectionsUseCase getDirectionsUseCase,
  })  : _getDirectionsUseCase = getDirectionsUseCase,
        super(DirectionsInitial());

  Future<void> getDirections(LatLng origin, LatLng destination) async {
    emit(DirectionsLoading());
    try {
      var directions = await _getDirectionsUseCase(
          "${origin.latitude},${origin.longitude}",
          "${destination.latitude},${destination.longitude}");
      emit(DirectionsSuccess(directions));
    } catch (err) {
      emit(DirectionsFailed(err.toString()));
    }
  }
}
