import 'package:user_app/common/constants/app_constants.dart';

/// Contains all endpoints to be use for API requests
sealed class Endpoint {
  static const String searchPlaces =
      'place/autocomplete/json?input={input}&key=${AppConstants.mapsKey}&components=country:in';

  static const String searchPlaceDetails =
      'place/details/json?place_id={place_id}&key=${AppConstants.mapsKey}';


  static const String directions =
      'directions/json?destination={destination}&origin={origin}&key=${AppConstants.mapsKey}';
}
