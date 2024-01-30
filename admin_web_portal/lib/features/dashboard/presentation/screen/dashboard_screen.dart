import 'dart:convert';

import 'package:admin_web_portal/common/extensions/build_context_extensions.dart';
import 'package:admin_web_portal/common/ui/modals/spacing.dart';
import 'package:admin_web_portal/common/ui/theme/core/app_colors.dart';
import 'package:admin_web_portal/features/drivers/data/models/driver_model.dart';
import 'package:admin_web_portal/features/drivers/presentation/screen/drivers_screen.dart';
import 'package:admin_web_portal/features/trips/presentation/screen/trips_screen.dart';
import 'package:admin_web_portal/features/users/presentation/screen/users_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Widget selectedPage = const DriversScreen();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      body: selectedPage,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          "Admin Portal",
          style: context.textTheme.titleLarge!.copyWith(color: Colors.white),
        ),
      ),
      sideBar: SideBar(
        items: const [
          AdminMenuItem(
            title: 'Drivers',
            route: DriversScreen.id,
            icon: CupertinoIcons.car_detailed,
          ),
          AdminMenuItem(
            title: 'Users',
            route: UsersScreen.id,
            icon: CupertinoIcons.person_2_fill,
          ),
          AdminMenuItem(
            title: 'Trips',
            route: TripsScreen.id,
            icon: CupertinoIcons.location_fill,
          ),
        ],
        selectedRoute: DriversScreen.id,
        onSelected: (page) {
          navigate(page);
        },
        header: Container(
          height: 50,
          color: AppColors.primary.withAlpha(90),
          width: double.infinity,
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              gapW10,
              Icon(
                Icons.accessibility,
                color: Colors.white,
              ),
              gapW14,
              Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ],
          ),
        ),
        footer:Container(
          height: 50,
          color: AppColors.primary.withAlpha(90),
          width: double.infinity,
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              gapW10,
              Icon(
                Icons.admin_panel_settings_outlined,
                color: Colors.white,
              ),
              gapW14,
              Icon(
                Icons.computer,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigate(AdminMenuItem page) {
    switch (page.route) {
      case DriversScreen.id:
        setState(() {
          selectedPage = const DriversScreen();
        });
        break;
      case UsersScreen.id:
        setState(() {
          selectedPage = const UsersScreen();
        });
        break;
      case TripsScreen.id:
        setState(() {
          selectedPage = const TripsScreen();
        });
        break;
      default:
        setState(() {
          selectedPage = const DriversScreen();
        });
        break;
    }
  }
}
