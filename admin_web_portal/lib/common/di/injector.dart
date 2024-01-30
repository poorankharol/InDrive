import 'package:admin_web_portal/features/drivers/data/datasource/database_remote_data_source.dart';
import 'package:admin_web_portal/features/drivers/data/datasource/database_remote_data_source_firebase.dart';
import 'package:admin_web_portal/features/drivers/data/repository/driver_repository_impl.dart';
import 'package:admin_web_portal/features/drivers/domain/repository/driver_repository.dart';
import 'package:admin_web_portal/features/users/data/datasource/users_remote_data_source.dart';
import 'package:admin_web_portal/features/users/data/datasource/users_remote_data_source_firebase.dart';
import 'package:admin_web_portal/features/users/data/repository/user_repository_impl.dart';
import 'package:admin_web_portal/features/users/domain/repository/user_repository.dart';
import 'package:get_it/get_it.dart';

import '../auth_services/authentication/enum/authentication_type.dart';
import '../auth_services/authentication/manager/authentication_manager.dart';
import '../auth_services/authentication/manager/authentication_manager_impl.dart';
import '../auth_services/authentication/provider/authentication_provider.dart';
import '../auth_services/authentication/provider/email/email_authentication_provider.dart';
import '../auth_services/token/token_manager.dart';
import '../auth_services/token/token_manager_impl.dart';
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

  //Repo
  DatabaseRemoteDataSource authRemoteDataSource =
      DatabaseRemoteDataSourceFirebase();
  injector.registerSingleton<DriverRepository>(
      DriverRepositoryImpl(remoteDataSource: authRemoteDataSource));
  UsersRemoteDataSource usersRemoteDataSource = UsersRemoteDataSourceFirebase();
  injector.registerSingleton<UserRepository>(
      UserRepositoryImpl(remoteDataSource: usersRemoteDataSource));
  //Validation
  injector.registerSingleton<ValidationManager>(ValidationManagerImpl());
}
