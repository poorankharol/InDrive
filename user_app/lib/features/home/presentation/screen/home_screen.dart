import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:user_app/common/constants/app_constants.dart';
import 'package:user_app/common/extensions/build_context_extensions.dart';
import 'package:user_app/common/extensions/snack_bar.dart';
import 'package:user_app/common/navigation/route_name.dart';
import 'package:user_app/common/ui/theme/core/app_colors.dart';
import 'package:user_app/common/utils/permission/permission_manager.dart';
import 'package:user_app/features/home/data/models/address_model.dart';
import 'package:user_app/features/home/data/models/user_model.dart';
import 'package:user_app/features/home/presentation/cubit/directions/directions_cubit.dart';
import 'package:user_app/features/home/presentation/cubit/user/get_user_cubit.dart';
import 'package:user_app/features/home/presentation/widget/bottom_widget.dart';
import 'package:user_app/features/home/presentation/widget/google_map_widget.dart';

import '../../data/models/directions_model.dart';
import '../../data/models/geocoding_model.dart';
import '../cubit/location/end/user_end_location_cubit.dart';
import '../cubit/location/start/user_start_location_cubit.dart';
import '../widget/drawer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: BlocConsumer<GetUserCubit, GetUserState>(
        listener: (context, state) {
          if (state is GetUserFailed) {
            print(state.error);
          }
          if (state is GetUserSuccess) {
            UserModel? user = state.userModel;
            if (user!.blockStatus) {
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteName.registerScreen, (route) => true);
            }
          }
        },
        builder: (context, state) {
          if (state is GetUserSuccess) {
            UserModel? user = state.userModel;
            return DrawerWidget(
              user: user!,
            );
          }
          return const SizedBox();
        },
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return SafeArea(
      child: Stack(
        children: [
          GoogleMapWidget(),
          Positioned(
            top: 15,
            left: 15,
            child: InkWell(
              onTap: () {
                _key.currentState!.openDrawer();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      spreadRadius: 0.5,
                      offset: Offset(
                        0.7,
                        0.7,
                      ),
                    )
                  ],
                ),
                child: CircleAvatar(
                  backgroundColor:
                      context.mediaQuery.platformBrightness == Brightness.dark
                          ? AppColors.primaryDark
                          : AppColors.primary,
                  radius: 25,
                  child: const Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
          const BottomWidget(),
        ],
      ),
    );
  }

  void getUser() {
    context.read<GetUserCubit>().getUser();
  }
}
