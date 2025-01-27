import 'package:comro_alt/common/widgets/custom_shapes/container/circular_icon.dart';
import 'package:comro_alt/utils/constants/colors.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CProductQuantity extends StatelessWidget {
  const CProductQuantity({
    super.key,
    required this.quantity,
    this.add,
    this.remove,
  });

  final int quantity;
  final VoidCallback? add, remove;

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // add remove button
        Row(
          children: [
            CCircularIcon(
              icon: Iconsax.minus,
              width: 32,
              height: 32,
              size: CSizes.md,
              color: dark ? CColors.white : CColors.black,
              backgroundColor: dark ? CColors.darkerGrey : CColors.softGrey,
              onPressed: remove,
            ),
            const SizedBox(width: CSizes.spaceBtwItems),

            //quantity
            Text(
              quantity.toString(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(width: CSizes.spaceBtwItems),
            CCircularIcon(
              icon: Iconsax.add,
              width: 32,
              height: 32,
              size: CSizes.md,
              color: CColors.white,
              backgroundColor: CColors.primary,
              onPressed: add,
            ),
          ],
        ),
      ],
    );
  }
}
