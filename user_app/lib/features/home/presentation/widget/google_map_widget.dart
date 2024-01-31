import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:user_app/common/extensions/build_context_extensions.dart';
import 'package:user_app/common/extensions/snack_bar.dart';

import '../../../../common/constants/app_constants.dart';
import '../../../../common/utils/permission/permission_manager.dart';
import '../../data/models/address_model.dart';
import '../../data/models/directions_model.dart';
import '../../data/models/geocoding_model.dart';
import '../cubit/directions/directions_cubit.dart';
import '../cubit/location/end/user_end_location_cubit.dart';
import '../cubit/location/start/user_start_location_cubit.dart';

class GoogleMapWidget extends StatefulWidget {
  const GoogleMapWidget({super.key});

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  late GoogleMapController _googleMapController;
  final Completer<GoogleMapController> _googleMapCompleteController =
  Completer();
  Position? _currentPosition;
  Set<Polyline> polylineSet = {};
  Set<Marker> markerSet = {};
  Set<Circle> circleSet = {};

  @override
  void initState() {
    super.initState();
    askLocationPermission();
  }

  @override
  dispose() {
    _googleMapController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DirectionsCubit, DirectionsState>(
      listener: (context, state) {
        if (state is DirectionsSuccess) {
          DirectionsModel directionsModel =
              state.directionsModel;
          drawPolyLines(directionsModel);
        }
      },
      builder: (context, state) {
        return GoogleMap(
          padding: EdgeInsets.only(
            top: 5,
            bottom: context.mediaQuery.size.height * 0.45,
          ),
          initialCameraPosition: _kGooglePlex,
          mapType: MapType.normal,
          myLocationEnabled: true,
          markers: markerSet,
          circles: circleSet,
          polylines: polylineSet,
          onMapCreated: (GoogleMapController mapController) {
            _googleMapController = mapController;
            _googleMapCompleteController.complete(mapController);
            updateMapStyle(mapController);
          },
        );
      },
    );
  }

  void drawPolyLines(DirectionsModel model) {
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> originDestinationLatLng =
    polylinePoints.decodePolyline(model.routes[0].overviewPolyline.points);

    List<LatLng> polylineCoordinates = [];
    for (var pointLatLng in originDestinationLatLng) {
      polylineCoordinates
          .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
    }

    polylineSet.clear();

    Polyline polyline = Polyline(
        polylineId: const PolylineId("polylineId"),
        color: Colors.pink,
        points: polylineCoordinates,
        jointType: JointType.round,
        width: 4,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true);

    polylineSet.add(polyline);

    LatLngBounds boundsLatLng;

    AddressModel startLocation = context.read<UserStartLocationCubit>().origin!;
    AddressModel endLocation =
    context.read<UserEndLocationCubit>().destination!;

    var origin = LatLng(startLocation.lat!, startLocation.long!);
    var destination = LatLng(endLocation.lat!, endLocation.long!);

    if (origin.latitude > destination.latitude &&
        origin.longitude > destination.longitude) {
      boundsLatLng = LatLngBounds(
        southwest: destination,
        northeast: origin,
      );
    } else if (origin.longitude > destination.longitude) {
      boundsLatLng = LatLngBounds(
        southwest: LatLng(origin.latitude, destination.longitude),
        northeast: LatLng(destination.latitude, origin.longitude),
      );
    } else if (origin.latitude > destination.latitude) {
      boundsLatLng = LatLngBounds(
        southwest: LatLng(destination.latitude, origin.longitude),
        northeast: LatLng(origin.latitude, destination.longitude),
      );
    } else {
      boundsLatLng = LatLngBounds(
        southwest: origin,
        northeast: destination,
      );
    }
    _googleMapController
        .animateCamera(CameraUpdate.newLatLngBounds(boundsLatLng, 72));

    //add markers to pickup and dropOffDestination points
    Marker pickUpPointMarker = Marker(
      markerId: const MarkerId("pickUpPointMarkerID"),
      position: origin,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow: InfoWindow(title: startLocation.placeName, snippet: "Pickup Location"),
    );

    Marker dropOffDestinationPointMarker = Marker(
      markerId: const MarkerId("dropOffDestinationPointMarkerID"),
      position: destination,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      infoWindow: InfoWindow(title: endLocation.placeName, snippet: "Destination Location"),
    );

    markerSet.add(pickUpPointMarker);
    markerSet.add(dropOffDestinationPointMarker);

    //add circles to pickup and dropOffDestination points
    Circle pickUpPointCircle = Circle(
      circleId: const CircleId('pickupCircleID'),
      strokeColor: Colors.blue,
      strokeWidth: 4,
      radius: 14,
      center: origin,
      fillColor: Colors.pink,
    );

    Circle dropOffDestinationPointCircle = Circle(
      circleId: const CircleId('dropOffDestinationCircleID'),
      strokeColor: Colors.blue,
      strokeWidth: 4,
      radius: 14,
      center: destination,
      fillColor: Colors.pink,
    );

    circleSet.add(pickUpPointCircle);
    circleSet.add(dropOffDestinationPointCircle);
  }

  updateMapStyle(GoogleMapController controller) {
    if (context.mediaQuery.platformBrightness == Brightness.dark) {
      getJSONFromAssets("assets/raw/dark_style.json").then((value) {
        setGoogleMapStyle(value, controller);
      });
    }
  }

  void setGoogleMapStyle(
      String googleMapStyle, GoogleMapController controller) {
    controller.setMapStyle(googleMapStyle);
  }

  Future<String> getJSONFromAssets(String path) async {
    ByteData byteData = await rootBundle.load(path);
    var data = byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
    return utf8.decode(data);
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
          context
              .read<UserStartLocationCubit>()
              .updatePickLocation(addressModel);
        }
      } else {
        print("Error");
      }
    } catch (e) {
      print("Error-$e");
    }
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
}
