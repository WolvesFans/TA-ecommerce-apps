import 'package:comro_alt/utils/constants/colors.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CHomeContainer extends StatelessWidget {
  const CHomeContainer({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon = Iconsax.bag_2,
    this.onTap,
    required this.width,
  });

  final String title, subtitle;
  final IconData? icon;
  final void Function()? onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(CSizes.md),
        height: 117,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(CSizes.md),
          border: Border.all(
            color: dark ? CColors.white : CColors.black,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: CSizes.sm),
                  Text(
                    subtitle,
                  )
                ],
              ),
            ),
            const SizedBox(width: CSizes.spaceBtwItems),
            Icon(
              icon,
              color: dark ? CColors.white : CColors.black,
            )
          ],
        ),
      ),
    );
  }
}
