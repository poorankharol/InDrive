import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:user_app/common/constants/app_constants.dart';
import 'package:user_app/common/extensions/build_context_extensions.dart';
import 'package:user_app/common/extensions/snack_bar.dart';
import 'package:user_app/common/navigation/route_name.dart';
import 'package:user_app/common/ui/theme/core/app_colors.dart';
import 'package:user_app/common/ui/widgets/buttons/circle_button.dart';
import 'package:user_app/common/utils/permission/permission_manager.dart';
import 'package:user_app/features/home/data/models/address_model.dart';
import 'package:user_app/features/home/data/models/user_model.dart';
import 'package:user_app/features/home/presentation/cubit/location/user_location_cubit.dart';
import 'package:user_app/features/home/presentation/cubit/user/get_user_cubit.dart';

import '../../data/models/geocoding_model.dart';
import '../widget/drawer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  late GoogleMapController _googleMapController;
  final Completer<GoogleMapController> _googleMapCompleteController =
      Completer();
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    askLocationPermission();
    getUser();
  }

  @override
  dispose() {
    _googleMapController.dispose();
    super.dispose();
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
          GoogleMap(
            padding: EdgeInsets.only(
                top: 5, bottom: context.mediaQuery.size.height * 0.45),
            initialCameraPosition: _kGooglePlex,
            mapType: MapType.normal,
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController mapController) {
              _googleMapController = mapController;
              _googleMapCompleteController.complete(mapController);
            },
          ),
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
          Positioned(
            bottom: -40,
            right: 0,
            left: 0,
            child: SizedBox(
              width: context.mediaQuery.size.width,
              height: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        RouteName.searchScreen,
                      );
                    },
                    icon: Icons.search_rounded,
                  ),
                  CircleButton(
                    onPressed: () {},
                    icon: Icons.work,
                  ),
                  CircleButton(
                    onPressed: () {},
                    icon: Icons.shopping_bag_rounded,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  updateMapStyle(GoogleMapController controller) {
    getJSONFromAssets("assets/raw/dark_style.json").then((value) {
      setGoogleMapStyle(value, controller);
    });
  }

  setGoogleMapStyle(String googleMapStyle, GoogleMapController controller) {
    controller.setMapStyle(googleMapStyle);
  }

  Future<String> getJSONFromAssets(String path) async {
    ByteData byteData = await rootBundle.load(path);
    var data = byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
    return utf8.decode(data);
  }

  void askLocationPermission() async {
    bool permission = await PermissionManager.requestPermission(
        Permission.locationWhenInUse, "Location Permission");

    if (permission) {
      determinePosition();
    } else {
      showErrorSnackbar("Permission not granted");
    }
  }

  Future<void> determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      showLocationServiceDisabledSnackbar();
      return;
    } else {
      try {
        _currentPosition = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.bestForNavigation);

        LatLng latLng =
            LatLng(_currentPosition!.latitude, _currentPosition!.longitude);

        CameraPosition cameraPosition =
            CameraPosition(target: latLng, zoom: 15);

        _googleMapController
            .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

        getCurrentAddress(_currentPosition!);
      } catch (e) {
        // Handle exceptions when getting the current position
        print("Error getting location: $e");
      }
    }
  }

  void showLocationServiceDisabledSnackbar() {
    if (mounted) {
      context.showSnackbarWithAction(
        message: "Location Permission not granted",
        label: "Settings",
        onPressed: () async {
          await Geolocator.openLocationSettings();
        },
      );
    }
  }

  void showErrorSnackbar(String message) {
    if (mounted) {
      context.showSnackbarWithAction(
        message: message,
        label: "App Settings",
        onPressed: () async {
          await Geolocator.openAppSettings();
        },
      );
    }
  }

  void getUser() {
    context.read<GetUserCubit>().getUser();
  }

  void getCurrentAddress(Position position) async {
    Dio dio = Dio();
    try {
      Response result = await dio.get(
          "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=${AppConstants.mapsKey}");
      if (result.statusCode == 200) {
        final body = result.data;
        final data = Map<String, dynamic>.from(body as Map);
        final mapsData = GeocodingModel.fromJson(data);
        var address = mapsData.results[0].formattedAddress;
        AddressModel addressModel = AddressModel(
          address: address,
          lat: position.latitude,
          long: position.longitude,
        );
        if (mounted) {
          context.read<UserLocationCubit>().updatePickLocation(addressModel);
        }
      } else {
        print("Error");
      }
    } catch (e) {
      print("Error-$e");
    }
  }
}
