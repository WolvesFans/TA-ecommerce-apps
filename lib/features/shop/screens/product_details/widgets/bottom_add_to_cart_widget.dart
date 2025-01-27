import 'package:comro_alt/common/widgets/custom_shapes/container/circular_icon.dart';
import 'package:comro_alt/features/shop/controllers/cart_controller.dart';
import 'package:comro_alt/features/shop/models/product_model.dart';
import 'package:comro_alt/utils/constants/colors.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/constants/text_strings.dart';
import 'package:comro_alt/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CBottomAddToCart extends StatelessWidget {
  const CBottomAddToCart({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    controller.updateAlreadyAddedProductCount(product);
    final dark = CHelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: CSizes.defaultSpace,
        vertical: CSizes.defaultSpace / 2,
      ),
      decoration: BoxDecoration(
        color: dark ? CColors.darkerGrey : CColors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(CSizes.cardRadiusLg),
          topRight: Radius.circular(CSizes.cardRadiusLg),
        ),
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                //remove item
                CCircularIcon(
                  icon: Iconsax.minus,
                  backgroundColor: CColors.grey,
                  width: 40,
                  height: 40,
                  color: CColors.white,
                  onPressed: () => controller.productQuantityInCart.value < 1 ? null : controller.productQuantityInCart.value -= 1,
                ),
                const SizedBox(width: CSizes.spaceBtwItems),

                //item quantity
                Text(
                  controller.productQuantityInCart.toString(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(width: CSizes.spaceBtwItems),

                //add item
                CCircularIcon(
                  icon: Iconsax.add,
                  backgroundColor: CColors.black,
                  width: 40,
                  height: 40,
                  color: CColors.white,
                  onPressed: () => controller.productQuantityInCart += 1,
                )
              ],
            ),
            ElevatedButton(
              onPressed: controller.productQuantityInCart.value < 1 ? null : () => controller.addToCart(product),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(CSizes.md),
                backgroundColor: CColors.black,
                side: const BorderSide(color: Colors.transparent),
              ),
              child: Text(
                CText.addItem,
                style: Theme.of(context).textTheme.bodyLarge!.apply(color: CColors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
