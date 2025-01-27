import 'package:comro_alt/utils/constants/colors.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AdminContainer extends StatelessWidget {
  const AdminContainer({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });

  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(CSizes.defaultSpace),
        decoration: BoxDecoration(
          border: Border.all(color: dark ? CColors.white : CColors.black),
          borderRadius: BorderRadius.circular(CSizes.borderRadiusLg),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //left side
            Row(
              children: [
                //icon
                Icon(icon),
                SizedBox(width: CSizes.spaceBtwItems),
      
                //text
                Text(
                  text,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
      
            //right side
            Icon(Iconsax.arrow_right)
          ],
        ),
      ),
    );
  }
}
