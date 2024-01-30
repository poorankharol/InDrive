import 'package:admin_web_portal/common/di/injector.dart';
import 'package:admin_web_portal/features/drivers/domain/repository/driver_repository.dart';
import 'package:admin_web_portal/features/drivers/domain/usecase/get_driver_usecase.dart';
import 'package:admin_web_portal/features/drivers/presentation/cubit/drivers_cubit.dart';
import 'package:admin_web_portal/features/users/domain/repository/user_repository.dart';
import 'package:admin_web_portal/features/users/domain/usecase/get_user_usecase.dart';
import 'package:admin_web_portal/features/users/presentation/cubit/users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../common/localization/constants/languages.dart';
import '../../common/navigation/navigation_service.dart';
import '../../common/navigation/route_generator.dart';
import '../../common/navigation/route_name.dart';
import '../../common/ui/theme/app_themes.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DriversCubit(
              getDriverUseCase: GetDriverUseCase(
                driverRepository: injector<DriverRepository>(),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => UsersCubit(
              getUserUseCase: GetUserUseCase(
                userRepository: injector<UserRepository>(),
              ),
            ),
          ),
        ],
        child: MaterialApp(
            title: "Admin Panel",
            debugShowCheckedModeBanner: false,
            theme: AppThemes.themeLight,
            darkTheme: AppThemes.themeDark,
            themeMode: ThemeMode.system,
            navigatorKey: NavigationService.navigatorKey,
            supportedLocales: Languages.localeList,
            onGenerateRoute: RouteGenerator.generateRoutes,
            initialRoute: RouteName.initialRoute));
  }
}
