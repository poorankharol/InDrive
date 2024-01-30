import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/common/constants/image_constants.dart';
import 'package:user_app/common/extensions/build_context_extensions.dart';
import 'package:user_app/common/ui/modals/spacing.dart';
import 'package:user_app/features/home/presentation/cubit/location/user_location_cubit.dart';
import 'package:user_app/features/home/presentation/cubit/location/user_location_cubit.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
          Row(
            children: [
              gapW18,
              Image.asset(
                ImageConstants.startDestImagePath,
                width: 20,
                height: 20,
              ),
              gapW12,
              Expanded(
                child: BlocBuilder<UserLocationCubit, UserLocationState>(
                  builder: (context, state) {
                    if(state is UserLocationPickup){
                      var pickUp = state.pickUpAddress;
                      _pickUpAddController.text = pickUp!.address;
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
          ),
          gapH10,
          Row(
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
          ),
          gapH20,
        ],
      ),
    );
  }


}
