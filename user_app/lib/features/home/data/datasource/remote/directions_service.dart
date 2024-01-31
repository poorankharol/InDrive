import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:user_app/features/home/data/models/directions_model.dart';

import '../../../../../common/networking/constants/endpoints.dart';

part 'directions_service.g.dart';

@RestApi()
abstract class DirectionsService {
  factory DirectionsService(Dio dio, {String baseUrl}) = _DirectionsService;

  @GET(Endpoint.directions)
  Future<HttpResponse<DirectionsModel>> getDirections(@Path('origin') String origin,@Path('destination') String destination);
}
