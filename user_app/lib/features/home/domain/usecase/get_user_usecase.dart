import 'package:user_app/features/home/data/models/user_model.dart';
import 'package:user_app/features/home/domain/repository/home_repository.dart';

class GetUserUseCase {
  final HomeRepository homeRepository;

  GetUserUseCase({required this.homeRepository});

  Future<UserModel?> call() async {
    try {
      UserModel? authUser = await homeRepository.getUser();
      return authUser;
    } on ArgumentError catch (error) {
      throw Exception(error);
    } catch (error) {
      throw Exception(error);
    }
  }
}
