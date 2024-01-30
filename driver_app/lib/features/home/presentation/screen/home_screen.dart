import 'dart:async';
import 'dart:convert';

import 'package:driver_app/common/extensions/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../common/utils/permission/permission_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    askLocationPermission();
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: _kGooglePlex,
              mapType: MapType.normal,
              myLocationEnabled: true,
              onMapCreated: (GoogleMapController mapController) {
                _googleMapController = mapController;
                _googleMapCompleteController.complete(mapController);
                //updateMapStyle(_googleMapController);
              },
            )
          ],
        ),
      ),
    );
  }

  void askLocationPermission() async {
    var permission = await PermissionManager.requestPermission(
        Permission.locationWhenInUse, "Location Permission");

    if (permission) {
      _determinePosition();
    } else {
      if (mounted) {
        context.showSnackbarWithAction(
            message: "Location Permission not granted",
            label: "Settings",
            onPressed: () {});
      }
    }
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

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  _determinePosition() async {
    bool serviceEnabled;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      if (mounted) {
        context.showSnackbarWithAction(
            message: "Location Permission not granted",
            label: "Settings",
            onPressed: () {});
      }
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    _currentPosition = position;

    LatLng latLng =
        LatLng(_currentPosition!.latitude, _currentPosition!.longitude);

    CameraPosition cameraPosition = CameraPosition(target: latLng, zoom: 15);

    _googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }
}
