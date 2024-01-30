import 'package:admin_web_portal/common/extensions/build_context_extensions.dart';
import 'package:admin_web_portal/common/ui/theme/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

import '../../../../common/ui/modals/spacing.dart';
import '../../../../common/ui/widgets/table_header_widget.dart';

class TripsScreen extends StatefulWidget {
  static const String id = "\webPageTrips";

  const TripsScreen({super.key});

  @override
  State<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Manage Trips",
                style: context.textTheme.titleLarge,
              ),
              gapH14,
              const Row(
                children: [
                  TableHeaderWidget(flexValue: 2, title: "Trip Id"),
                  TableHeaderWidget(flexValue: 1, title: "User Name"),
                  TableHeaderWidget(flexValue: 1, title: "Driver Name"),
                  TableHeaderWidget(flexValue: 1, title: "Car Details"),
                  TableHeaderWidget(flexValue: 1, title: "Timings"),
                  TableHeaderWidget(flexValue: 1, title: "Fare"),
                  TableHeaderWidget(flexValue: 1, title: "View Details"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
