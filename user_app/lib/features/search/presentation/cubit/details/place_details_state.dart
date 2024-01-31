part of 'place_details_cubit.dart';

@immutable
abstract class PlaceDetailsState {}

class PlaceDetailsInitial extends PlaceDetailsState {}
class PlaceDetailsLoading extends PlaceDetailsState {}
class PlaceDetailsSuccess extends PlaceDetailsState {
  final PlaceDetailsModel placeDetailsModel;

  PlaceDetailsSuccess(this.placeDetailsModel);
}
class PlaceDetailsFailed extends PlaceDetailsState {
  final String error;

  PlaceDetailsFailed(this.error);
}