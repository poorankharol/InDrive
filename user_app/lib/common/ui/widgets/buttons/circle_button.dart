import 'package:flutter/material.dart';
import 'package:user_app/common/extensions/build_context_extensions.dart';
import 'package:user_app/common/ui/theme/core/app_colors.dart';

class CircleButton extends StatelessWidget {
  final void Function() onPressed;
  final IconData icon;

  const CircleButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(55, 55),
        padding: const EdgeInsets.all(10),
        shape: const CircleBorder(),
        backgroundColor: context.mediaQuery.platformBrightness == Brightness.dark
            ? AppColors.primaryDark
            : AppColors.primary,
      ),
      onPressed: onPressed,
      child: Icon(
        icon,
        color: Colors.white,
        size: 25,
      ),
    );
  }
}
