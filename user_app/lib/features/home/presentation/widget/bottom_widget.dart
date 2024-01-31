import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:user_app/common/extensions/build_context_extensions.dart';

import '../../../../common/constants/image_constants.dart';
import '../../../../common/navigation/route_name.dart';
import '../../../../common/ui/modals/spacing.dart';
import '../../../../common/ui/widgets/buttons/circle_button.dart';
import '../../../../common/ui/widgets/loading_dialog.dart';
import '../../../search/presentation/cubit/search/search_places_cubit.dart';
import '../../data/models/address_model.dart';
import '../../data/models/directions_model.dart';
import '../cubit/directions/directions_cubit.dart';
import '../cubit/location/end/user_end_location_cubit.dart';
import '../cubit/location/start/user_start_location_cubit.dart';

class BottomWidget extends StatefulWidget {
  const BottomWidget({super.key});



  @override
  State<BottomWidget> createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<BottomWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserEndLocationCubit, UserEndLocationState>(
      listener: (context, state) {
        if (state is UserEndLocation) {
          getDirections();
        }
      },
      builder: (context, state) {
        if (state is UserEndLocation) {
          return Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              width: context.mediaQuery.size.width,
              height: 250,
              decoration: const BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.white12,
                        blurRadius: 15,
                        spreadRadius: 0.5,
                        offset: Offset(0.7, 0.7))
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Card(
                  elevation: 10,
                  child: SizedBox(
                    width: context.mediaQuery.size.width * .70,
                    child: BlocConsumer<DirectionsCubit, DirectionsState>(
                      listener: (context, state) {

                      },
                      builder: (context, state) {
                        if (state is DirectionsLoading) {
                          return const Loader(message: "");
                        }
                        if (state is DirectionsSuccess) {
                          DirectionsModel directionsModel =
                              state.directionsModel;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    directionsModel
                                        .routes[0].legs[0].distance.text,
                                    style:
                                        context.textTheme.titleLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  gapW18,
                                  Text(
                                    "|",
                                    style:
                                        context.textTheme.titleLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  gapW18,
                                  Text(
                                    directionsModel
                                        .routes[0].legs[0].duration.text,
                                    style:
                                        context.textTheme.titleLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Image.asset(
                                ImageConstants.carImagePath,
                                width: 110,
                                height: 110,
                              ),
                              Text(
                                getFare(directionsModel),
                                style: context.textTheme.titleLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          );
                        }
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "",
                              style: context.textTheme.titleLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Image.asset(
                              ImageConstants.carImagePath,
                              width: 110,
                              height: 110,
                            ),
                            Text(
                              "",
                              style: context.textTheme.titleLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        return Positioned(
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
                    context.read<SearchPlacesCubit>().clearState();
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
        );
      },
    );
  }

  void getDirections() async {
    AddressModel startLocation = context.read<UserStartLocationCubit>().origin!;
    AddressModel endLocation =
        context.read<UserEndLocationCubit>().destination!;

    var origin = LatLng(startLocation.lat!, startLocation.long!);
    var destination = LatLng(endLocation.lat!, endLocation.long!);

    context.read<DirectionsCubit>().getDirections(origin, destination);
  }

  String getFare(DirectionsModel model) {
    double distancePerKmAmount = 0.4;
    double durationPerMinAmount = 0.3;
    double baseFare = 3;

    double totalDistanceTravelFareAmount =
        (model.routes[0].legs[0].distance.value / 100) * distancePerKmAmount;
    double totalDurationSpendFareAmount =
        (model.routes[0].legs[0].duration.value / 60) * durationPerMinAmount;

    double total =
        baseFare + totalDurationSpendFareAmount + totalDistanceTravelFareAmount;

    return "\u{20B9} ${total.toStringAsFixed(2)}";
  }


}
