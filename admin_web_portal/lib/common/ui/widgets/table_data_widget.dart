import 'package:admin_web_portal/common/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';

import '../theme/core/app_colors.dart';

class TableDataWidget extends StatelessWidget {
  const TableDataWidget(
      {super.key, required this.flexValue, required this.widget});

  final int flexValue;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flexValue,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: AppColors.grey)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: widget,
        ),
      ),
    );
  }
}
