import 'package:admin_web_portal/common/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../common/ui/modals/spacing.dart';
import '../../../../common/ui/widgets/table_header_widget.dart';
import '../widgets/users_list_widget.dart';

class UsersScreen extends StatefulWidget {
  static const String id ="\webPageUsers";
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
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
                "Manage Users",
                style: context.textTheme.titleLarge,
              ),
              gapH14,
              const Row(
                children: [
                  TableHeaderWidget(flexValue: 2, title: "User Id"),
                  TableHeaderWidget(flexValue: 1, title: "Name"),
                  TableHeaderWidget(flexValue: 1, title: "Email"),
                  TableHeaderWidget(flexValue: 1, title: "Phone"),
                  TableHeaderWidget(flexValue: 1, title: "Action"),
                ],
              ),
              gapH14,
              const UserListWidget()
            ],
          ),
        ),
      ),
    );
  }
}
