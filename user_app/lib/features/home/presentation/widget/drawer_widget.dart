import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/features/home/data/models/user_model.dart';
import 'package:user_app/features/home/presentation/cubit/signout/sign_out_cubit.dart';

import '../../../../common/constants/image_constants.dart';
import '../../../../common/navigation/route_name.dart';
import '../../../../common/ui/theme/core/app_colors.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key, required this.user});

  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: AppColors.primary),
            accountName: Text(
              user?.name ?? "",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(
              user?.email ?? "",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            currentAccountPicture: Image.asset(ImageConstants.manImagePath),
          ),
          ListTile(
            leading: const Icon(
              Icons.info_outline_rounded,
            ),
            title: const Text('About'),
            onTap: () {},
          ),
          BlocConsumer<SignOutCubit, SignOutState>(
            listener: (context, state) {
              if (state is SignOutSuccess) {
                Navigator.pushNamedAndRemoveUntil(
                    context, RouteName.registerScreen, (route) => true);
              }
            },
            builder: (context, state) {
              return ListTile(
                leading: const Icon(
                  Icons.logout_rounded,
                ),
                title: const Text('Logout'),
                onTap: () {
                  context.read<SignOutCubit>().signOut();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
