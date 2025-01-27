import 'package:comro_alt/utils/constants/colors.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CRoundedContainer extends StatelessWidget {
  const CRoundedContainer({
    super.key,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.radius = CSizes.cardRadiusLg,
    this.backgroundColor = CColors.white,
    this.borderColor = CColors.borderPrimary,
    this.showBorder = false,
    this.child,
  });

  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double radius;
  final Color backgroundColor;
  final Color borderColor;
  final bool showBorder;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: showBorder ? Border.all(color: borderColor) : null,
      ),
      child: child,
    );
  }
}
