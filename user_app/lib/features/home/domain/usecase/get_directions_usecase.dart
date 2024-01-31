import 'package:user_app/features/home/data/models/directions_model.dart';
import 'package:user_app/features/home/domain/repository/home_repository.dart';

class GetDirectionsUseCase {
  final HomeRepository homeRepository;

  GetDirectionsUseCase({required this.homeRepository});

  Future<DirectionsModel> call(String origin, String destination) async {
    try {
      DirectionsModel? directionModel =
          await homeRepository.getDirections(origin, destination);
      return directionModel;
    } on ArgumentError catch (error) {
      throw Exception(error);
    } catch (error) {
      throw Exception(error);
    }
  }
}
