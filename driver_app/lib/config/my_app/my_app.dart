import 'package:driver_app/features/register/domain/usecase/insert_driver_info_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:driver_app/features/login/domain/usercase/login_usecase.dart';
import 'package:driver_app/features/login/domain/usercase/sign_out_usecase.dart';
import 'package:driver_app/features/login/presentation/bloc/login_cubit.dart';
import 'package:driver_app/features/register/domain/usecase/register_usecase.dart';
import 'package:driver_app/features/register/presentation/bloc/register/register_cubit.dart';
import '../../common/di/injector.dart';
import '../../common/localization/bloc/language_bloc.dart';
import '../../common/localization/bloc/language_state.dart';
import '../../common/localization/constants/languages.dart';
import '../../common/localization/repository/language_repository.dart';
import '../../common/navigation/navigation_service.dart';
import '../../common/navigation/route_generator.dart';
import '../../common/navigation/route_name.dart';
import '../../common/ui/theme/app_themes.dart';
import '../../features/login/domain/repository/login_repository.dart';
import '../../features/register/domain/repository/register_repository.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.authUser});

  final User? authUser;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LanguageBloc(injector<LanguageRepository>()),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(
            registerUseCase: RegisterUseCase(
              authRepository: injector<RegisterRepository>(),
            ),
            insertDriverInfoUseCase: InsertDriverInfoUseCase(
                authRepository: injector<RegisterRepository>()),
          ),
        ),
        BlocProvider(
          create: (context) => LoginCubit(
            loginUseCase: LoginUseCase(
              authRepository: injector<LoginRepository>(),
            ),
            signOutUseCase: SignOutUseCase(
              authRepository: injector<LoginRepository>(),
            ),
          ),
        ),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppThemes.themeLight,
            darkTheme: AppThemes.themeDark,
            themeMode: ThemeMode.system,
            navigatorKey: NavigationService.navigatorKey,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            locale: state.locale,
            supportedLocales: Languages.localeList,
            onGenerateRoute: RouteGenerator.generateRoutes,
            initialRoute: authUser == null
                ? RouteName.initialRoute
                : RouteName.homeScreen,
          );
        },
      ),
    );
  }
}
