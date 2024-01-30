import 'package:flutter/material.dart';
import 'package:driver_app/common/extensions/build_context_extensions.dart';

import '../../constants/image_constants.dart';

class NoInternetConnection extends StatelessWidget {
  const NoInternetConnection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImageConstants.noInternetConnectionImagePath,
                height: 150,
                width: 150,
              ),
              const SizedBox(height: 25),
              Text(
                context.appLocale.noInternetConnection,
                style: context.textTheme.titleLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
