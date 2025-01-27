import 'package:comro_alt/utils/constants/colors.dart';
import 'package:comro_alt/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CCircularIcon extends StatelessWidget {
  const CCircularIcon({
    super.key,
    this.width,
    this.height,
    this.size,
    required this.icon,
    this.color,
    this.backgroundColor,
    this.onPressed,
  });

  final double? width, height, size;
  final IconData icon;
  final Color? color, backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: backgroundColor != null
              ? backgroundColor!
              : CHelperFunctions.isDarkMode(context)
                  ? CColors.black.withOpacity(0.9)
                  : CColors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(100)),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: color,
          size: size,
        ),
      ),
    );
  }
}
