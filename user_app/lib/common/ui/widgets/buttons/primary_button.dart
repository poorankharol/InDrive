import 'package:flutter/material.dart';
import 'package:user_app/common/extensions/build_context_extensions.dart';
import 'package:user_app/common/ui/theme/core/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final void Function() onPressed;
  final String label;
  final double width;
  final double height;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.width = 250,
    this.height = 50,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          fixedSize: Size(width, height),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
      onPressed: isLoading ? () {} : onPressed,
      child: AnimatedCrossFade(
        alignment: Alignment.center,
        firstChild: Text(
          label,
          style: context.textTheme.titleMedium!.copyWith(
            color: AppColors.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        secondChild: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircularProgressIndicator(color: Colors.white),
        ),
        crossFadeState:
            isLoading ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: const Duration(milliseconds: 500),
      ),
    );
  }
}
