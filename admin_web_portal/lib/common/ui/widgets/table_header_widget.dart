import 'package:admin_web_portal/common/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';

import '../theme/core/app_colors.dart';

class TableHeaderWidget extends StatelessWidget {
  const TableHeaderWidget(
      {super.key, required this.flexValue, required this.title});

  final int flexValue;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flexValue,
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.primary,
            border: Border.all(width: 1, color: Colors.white)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: context.textTheme.titleMedium!.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
