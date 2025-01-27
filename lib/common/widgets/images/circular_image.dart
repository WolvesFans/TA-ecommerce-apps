import 'package:cached_network_image/cached_network_image.dart';
import 'package:comro_alt/utils/constants/colors.dart';
import 'package:comro_alt/utils/etc/shimmer.dart';
import 'package:comro_alt/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CCircularImage extends StatelessWidget {
  const CCircularImage({
    super.key,
    this.width = 56,
    this.height = 56,
    required this.image,
    this.padding = 0,
    this.fit = BoxFit.fill,
    this.overlayColor,
    this.backgroundColor,
    this.isNetworkImage = false,
  });

  final double width, height, padding;
  final bool isNetworkImage;
  final String image;
  final BoxFit? fit;
  final Color? overlayColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        // klo bgcolor = null, ngikut light/dark mode
        color: backgroundColor ?? (CHelperFunctions.isDarkMode(context) ? CColors.black : CColors.white),
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: isNetworkImage
            ? CachedNetworkImage(
                fit: fit,
                color: overlayColor,
                imageUrl: image,
                progressIndicatorBuilder: (context, url, downloadProgress) => const CShimmerEffect(width: 55, height: 55, radius: 55),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )
            : Image(
                fit: fit,
                image: AssetImage(image),
                color: overlayColor,
              ),
      ),
    );
  }
}
