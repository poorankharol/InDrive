import 'package:flutter/material.dart';
import 'package:admin_web_portal/common/extensions/build_context_extensions.dart';

import '../../constants/image_constants.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImageConstants.noDataFoundImagePath,
                height: 150,
                width: 150,
              ),
              SizedBox(height: 25),
              Text(
                context.appLocale.noDataFound,
                style: context.textTheme.titleLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
