import 'package:comro_alt/utils/constants/colors.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CVerticalImageText extends StatelessWidget {
  const CVerticalImageText({
    super.key,
    this.image,
    required this.title,
    this.textColor = CColors.white,
    this.backgroundColor = CColors.white,
    this.onPressed,
  });

  final String? image, title;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final dark = CHelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.only(right: CSizes.spaceBtwItems),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          title!,
          style: Theme.of(context).textTheme.bodyLarge!.apply(color: textColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
