import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:user_app/common/auth_services/authentication/provider/email/email_authentication_provider.dart';
import 'package:user_app/features/home/data/datasource/remote/directions_service.dart';
import 'package:user_app/features/home/data/datasource/user_remote_data_source.dart';
import 'package:user_app/features/home/data/datasource/user_remote_data_source_firebase.dart';
import 'package:user_app/features/home/data/repository/home_repository_impl.dart';
import 'package:user_app/features/home/domain/repository/home_repository.dart';
import 'package:user_app/features/login/data/repository/login_repository_impl.dart';
import 'package:user_app/features/login/domain/repository/login_repository.dart';
import 'package:user_app/features/register/data/repository/register_repository_impl.dart';
import 'package:user_app/features/register/domain/repository/register_repository.dart';
import 'package:user_app/features/search/data/datasource/remote/search_places_service.dart';
import 'package:user_app/features/search/data/repository/search_place_repository_impl.dart';
import 'package:user_app/features/search/domain/repository/search_place_repository.dart';

import '../auth_services/authentication/enum/authentication_type.dart';
import '../auth_services/authentication/manager/authentication_manager.dart';
import '../auth_services/authentication/manager/authentication_manager_impl.dart';
import '../auth_services/authentication/provider/authentication_provider.dart';
import '../auth_services/token/token_manager.dart';
import '../auth_services/token/token_manager_impl.dart';
import '../firebase/data_sources/auth_remote_data_source.dart';
import '../firebase/data_sources/auth_remote_data_source_firebase.dart';
import '../localization/repository/language_repository.dart';
import '../localization/repository/language_repository_impl.dart';
import '../networking/dio/dio_client.dart';
import '../validation/validation_manager_impl.dart';
import '../validation/validators_manager.dart';

///Create Instance for GetIt.
final injector = GetIt.instance;

///Setup Dependency Injection using GetIt.
Future<void> setupDI() async {
  //authentication
  injector.registerLazySingleton<AuthenticationProvider>(
      () => EmailAuthenticationProvider(),
      instanceName: AuthenticationType.Email.name);
  injector
      .registerSingleton<AuthenticationManager>(AuthenticationManagerImpl());
  injector.registerSingleton<TokenManager>(TokenManagerImpl());

  // <dio_instance>
  final dio = buildDioClient();
  injector.registerSingleton<Dio>(dio);

  // api_clients
  injector.registerSingleton<SearchPlacesService>(
      SearchPlacesService(injector<Dio>()));
  injector
      .registerSingleton<DirectionsService>(DirectionsService(injector<Dio>()));

  //DataSource
  AuthRemoteDataSource authRemoteDataSource = AuthRemoteDataSourceFirebase();
  UserRemoteDataSource userRemoteDataSource = UserRemoteDataSourceFirebase();

  // repositories
  injector.registerSingleton<LanguageRepository>(LanguageRepositoryImpl());
  injector.registerSingleton<RegisterRepository>(
      RegisterRepositoryImpl(remoteDataSource: authRemoteDataSource));
  injector.registerSingleton<LoginRepository>(
      LoginRepositoryImpl(remoteDataSource: authRemoteDataSource));
  injector.registerSingleton<HomeRepository>(HomeRepositoryImpl(
      remoteDataSource: authRemoteDataSource,
      userRemoteDataSource: userRemoteDataSource,
      directionsService: injector<DirectionsService>()));

  injector.registerSingleton<SearchPlaceRepository>(SearchPlaceRepositoryImpl(
      searchPlacesService: injector<SearchPlacesService>()));

  //Validation
  injector.registerSingleton<ValidationManager>(ValidationManagerImpl());
}
