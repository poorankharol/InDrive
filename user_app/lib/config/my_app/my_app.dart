import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:user_app/features/home/domain/repository/home_repository.dart';
import 'package:user_app/features/home/domain/usecase/get_directions_usecase.dart';
import 'package:user_app/features/home/domain/usecase/get_user_usecase.dart';
import 'package:user_app/features/home/presentation/cubit/directions/directions_cubit.dart';
import 'package:user_app/features/home/presentation/cubit/location/start/user_start_location_cubit.dart';
import 'package:user_app/features/home/presentation/cubit/signout/sign_out_cubit.dart';
import 'package:user_app/features/home/presentation/cubit/user/get_user_cubit.dart';
import 'package:user_app/features/login/domain/usercase/login_usecase.dart';
import 'package:user_app/features/login/domain/usercase/sign_out_usecase.dart';
import 'package:user_app/features/login/presentation/bloc/login_cubit.dart';
import 'package:user_app/features/register/data/repository/register_repository_impl.dart';
import 'package:user_app/features/register/domain/usecase/register_usecase.dart';
import 'package:user_app/features/register/presentation/bloc/register_cubit.dart';
import 'package:user_app/features/search/domain/repository/search_place_repository.dart';
import 'package:user_app/features/search/domain/usecase/place_details_usecase.dart';
import 'package:user_app/features/search/domain/usecase/search_places_usecase.dart';
import 'package:user_app/features/search/presentation/cubit/details/place_details_cubit.dart';
import 'package:user_app/features/search/presentation/cubit/search/search_places_cubit.dart';
import '../../common/di/injector.dart';
import '../../common/localization/bloc/language_bloc.dart';
import '../../common/localization/bloc/language_state.dart';
import '../../common/localization/constants/languages.dart';
import '../../common/localization/repository/language_repository.dart';
import '../../common/navigation/navigation_service.dart';
import '../../common/navigation/route_generator.dart';
import '../../common/navigation/route_name.dart';
import '../../common/ui/theme/app_themes.dart';
import '../../features/home/presentation/cubit/location/end/user_end_location_cubit.dart';
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
        BlocProvider(
          create: (context) => GetUserCubit(
            getUserUseCase: GetUserUseCase(
              homeRepository: injector<HomeRepository>(),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => SignOutCubit(
            signOutUseCase: SignOutUseCase(
              authRepository: injector<LoginRepository>(),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => UserStartLocationCubit(),
        ),
        BlocProvider(
          create: (context) => UserEndLocationCubit(),
        ),
        BlocProvider(
          create: (context) => SearchPlacesCubit(
            searchPlacesUseCase: SearchPlacesUseCase(
              searchPlaceRepository: injector<SearchPlaceRepository>(),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => PlaceDetailsCubit(
            placeDetailsUseCase: PlaceDetailsUseCase(
              searchPlaceRepository: injector<SearchPlaceRepository>(),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => DirectionsCubit(
            getDirectionsUseCase: GetDirectionsUseCase(
                homeRepository: injector<HomeRepository>()),
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
