import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:user_app/common/constants/image_constants.dart';
import 'package:user_app/common/extensions/build_context_extensions.dart';
import 'package:user_app/common/ui/modals/spacing.dart';
import 'package:user_app/features/search/data/models/places_model.dart';
import 'package:user_app/features/search/presentation/cubit/details/place_details_cubit.dart';
import 'package:user_app/features/search/presentation/cubit/search/search_places_cubit.dart';

import '../../../../common/utils/dialogs/dialogs.dart';
import '../../../../common/extensions/bloc_extension.dart';
import '../../../home/data/models/address_model.dart';
import '../../../home/presentation/cubit/location/end/user_end_location_cubit.dart';
import '../../../home/presentation/cubit/location/start/user_start_location_cubit.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  late TextEditingController _pickUpAddController;
  late TextEditingController _destinationAddController;

  @override
  void initState() {
    _pickUpAddController = TextEditingController();
    _destinationAddController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _pickUpAddController.dispose();
    _destinationAddController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
    );
  }

  SafeArea buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildCard(),
            gapH20,
            buildListView(),
          ],
        ),
      ),
    );
  }

  Card buildCard() {
    return Card(
      elevation: 5,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Set DropOff Location",
                  style: context.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          gapH10,
          buildStartLocationRow(),
          gapH10,
          buildEndLocationRow(),
          gapH20,
        ],
      ),
    );
  }

  Widget buildEndLocationRow() {
    return Row(
      children: [
        gapW18,
        Image.asset(
          ImageConstants.endDestImagePath,
          width: 20,
          height: 20,
        ),
        gapW12,
        Expanded(
          child: TextFormField(
            onChanged: (value) {
              searchPlaces(value);
            },
            controller: _destinationAddController,
            decoration: const InputDecoration(
              hintText: 'Destination Address',
              contentPadding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
            ),
          ),
        ),
        gapW18,
      ],
    );
  }

  Widget buildAutoCompleteView() {
    return Expanded(
      child: TypeAheadField<Prediction>(
        suggestionsCallback: (search) => searchPlacesTypeAhead(search),
        controller: _destinationAddController,
        builder: (context, controller, focusNode) {
          return TextField(
            controller: controller,
            focusNode: focusNode,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Destination Address',
              contentPadding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
            ),
          );
        },
        hideOnLoading: true,
        hideOnError: true,
        //loadingBuilder: (context) => const Text('Loading...'),
        emptyBuilder: (context) => const SizedBox.shrink(),
        itemBuilder: (context, prediction) {
          return ListTile(
            tileColor: Colors.white,
            title: Text(
                "${prediction.structuredFormatting.mainText},${prediction.structuredFormatting.secondaryText}"),
          );
        },
        onSelected: (prediction) {
          _destinationAddController.text =
              "${prediction.structuredFormatting.mainText},${prediction.structuredFormatting.secondaryText}";
        },
      ),
    );
  }

  Widget buildStartLocationRow() {
    return Row(
      children: [
        gapW18,
        Image.asset(
          ImageConstants.startDestImagePath,
          width: 20,
          height: 20,
        ),
        gapW12,
        Expanded(
          child: BlocBuilder<UserStartLocationCubit, UserStartLocationState>(
            builder: (context, state) {
              if (state is UserStartLocation) {
                var pickUp = state.pickUpAddress;
                _pickUpAddController.text = pickUp!.address!;
                return TextFormField(
                  controller: _pickUpAddController,
                  decoration: const InputDecoration(
                    hintText: 'Pickup Address',
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                  ),
                );
              }
              return gapW4;
            },
          ),
        ),
        gapW18,
      ],
    );
  }

  Future<List<Prediction>> searchPlacesTypeAhead(String input) async {
    if (input.length > 1) {
      final bloc = context.read<SearchPlacesCubit>();
      PlacesModel data = await bloc.searchPlacesTypeAhead(input: input);
      return data.predictions;
    } else {
      return [];
    }
  }

  void searchPlaces(String input) async {
    context.read<SearchPlacesCubit>().searchPlaces(input: input);
  }

  Widget buildListView() {
    return BlocListener<PlaceDetailsCubit, PlaceDetailsState>(
      listener: (context, state) {
        if (state is PlaceDetailsSuccess) {
          Navigator.pop(_keyLoader.currentContext!);
          final placeDetails = state.placeDetailsModel;
          AddressModel addressModel = AddressModel(
              lat: placeDetails.result.geometry.location.lat,
              long: placeDetails.result.geometry.location.lng,
              placeName: placeDetails.result.name,
              placeId: placeDetails.result.placeId);

          if (mounted) {
            context
                .read<UserEndLocationCubit>()
                .updateDestinationLocation(addressModel);
            Navigator.pop(context);
          }
        }
        if (state is PlaceDetailsLoading) {
          Dialogs.showLoadingDialog(context, _keyLoader);
        }
        if (state is PlaceDetailsFailed) {
          Navigator.pop(_keyLoader.currentContext!); //close the dialoge
          print(state.error);
        }
      },
      child: BlocBuilder<SearchPlacesCubit, SearchPlacesState>(
        builder: (context, state) {
          if (state is SearchPlacesSuccess) {
            List<Prediction> predictionList = state.placesModel.predictions;
            return ListView.separated(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: predictionList.length,
              itemBuilder: (ctx, index) {
                final prediction = predictionList[index];
                return InkWell(
                  onTap: () {
                    context
                        .read<PlaceDetailsCubit>()
                        .searchPlaces(placeId: prediction.placeId);
                  },
                  child: Column(
                    children: [
                      Row(
                        children: [
                          gapW10,
                          Image.asset(
                            ImageConstants.trackingDestImagePath,
                            width: 24,
                            height: 24,
                          ),
                          Expanded(
                            child: ListTile(
                              dense: true,
                              visualDensity: const VisualDensity(
                                  horizontal: 0, vertical: -4),
                              //tileColor: Colors.white,
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                    prediction.structuredFormatting.mainText),
                              ),
                              subtitle: Text(prediction
                                  .structuredFormatting.secondaryText),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            );
          }
          if (state is SearchPlacesLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
