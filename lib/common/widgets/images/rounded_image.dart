import 'package:comro_alt/utils/constants/colors.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CRoundedImage extends StatelessWidget {
  const CRoundedImage({
    super.key,
    this.width,
    this.height,
    required this.imageUrl,
    this.applyImageRadius = false,
    this.isNetworkImage = false,
    this.border,
    this.backgroundColor = CColors.light,
    this.fit = BoxFit.contain,
    this.padding,
    this.onPressed,
    this.borderRadius = CSizes.md,
  });

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius, isNetworkImage;
  final BoxBorder? border;
  final Color backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius ? BorderRadius.circular(borderRadius) : BorderRadius.zero,
          child: Image(
            fit: fit,
            image: isNetworkImage ? NetworkImage(imageUrl) : AssetImage(imageUrl) as ImageProvider,
          ),
        ),
      ),
    );
  }
}
