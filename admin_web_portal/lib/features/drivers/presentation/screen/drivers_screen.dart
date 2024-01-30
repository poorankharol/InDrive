import 'package:admin_web_portal/common/extensions/build_context_extensions.dart';
import 'package:admin_web_portal/common/ui/modals/spacing.dart';
import 'package:admin_web_portal/features/drivers/presentation/widgets/drivers_list_widget.dart';
import 'package:flutter/material.dart';

import '../../../../common/ui/widgets/table_header_widget.dart';

class DriversScreen extends StatefulWidget {
  static const String id = "\webPageDrivers";

  const DriversScreen({super.key});

  @override
  State<DriversScreen> createState() => _DriversScreenState();
}

class _DriversScreenState extends State<DriversScreen> {
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
                "Manage Drivers",
                style: context.textTheme.titleLarge,
              ),
              gapH14,
              const Row(
                children: [
                  TableHeaderWidget(flexValue: 2, title: "Driver Id"),
                  TableHeaderWidget(flexValue: 1, title: "Photo"),
                  TableHeaderWidget(flexValue: 1, title: "Name"),
                  TableHeaderWidget(flexValue: 1, title: "Car Details"),
                  TableHeaderWidget(flexValue: 1, title: "Phone"),
                  TableHeaderWidget(flexValue: 1, title: "Total Earnings"),
                  TableHeaderWidget(flexValue: 1, title: "Action"),
                ],
              ),
              gapH14,
              const DriverListWidget()
            ],
          ),
        ),
      ),
    );
  }
}
