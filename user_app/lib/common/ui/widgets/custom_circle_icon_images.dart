import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CircleIcon extends StatelessWidget {
  final String iconPath;
  final Function() onClick;
  final Color backgroundColor;

  const CircleIcon({
    required this.iconPath,
    required this.onClick,
    this.backgroundColor = Colors.white30,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: onClick,
          customBorder:const CircleBorder(),
          child: CircleAvatar(
            radius: 24.0,
            backgroundColor: backgroundColor,
            child: SvgPicture.asset(iconPath),
          ),
        ),
      ),
    );
  }
}

class CircleImage extends StatelessWidget {
  final String imagePath;
  final Function() onClick;
  final Color backgroundColor;

  const CircleImage({
    required this.imagePath,
    required this.onClick,
    this.backgroundColor = Colors.white30,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: onClick,
          customBorder:const CircleBorder(),
          child: CircleAvatar(
            radius: 24.0,
            backgroundColor: backgroundColor,
            child: Image.asset(
              imagePath,
              color: Colors.white,
              height: 24,
              width: 24,
            ),
          ),
        ),
      ),
    );
  }
}
