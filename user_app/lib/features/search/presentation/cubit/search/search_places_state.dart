part of 'search_places_cubit.dart';

@immutable
abstract class SearchPlacesState {}

class SearchPlacesInitial extends SearchPlacesState {}
class SearchPlacesLoading extends SearchPlacesState {}
class SearchPlacesSuccess extends SearchPlacesState {
  final PlacesModel placesModel;

  SearchPlacesSuccess(this.placesModel);
}
class SearchPlacesFailed extends SearchPlacesState {
  final String error;

  SearchPlacesFailed(this.error);
}