import 'package:comro_alt/features/shop/controllers/cart_controller.dart';
import 'package:comro_alt/features/shop/screens/cart/cart.dart';
import 'package:comro_alt/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CCartCounterIcon extends StatelessWidget {
  const CCartCounterIcon({
    super.key,
    this.iconColor,
  });

  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    //get an instance of the CartController
    final controller = Get.put(CartController());

    return Stack(
      children: [
        IconButton(
          onPressed: () => Get.to(() => const CartScreen()), 
          icon: const Icon(Iconsax.shopping_cart),
          color: iconColor,
        ),
        Positioned(
          right: 2,
          top: 5,
          child: Container(
            height: 18,
            width: 18,
            decoration: BoxDecoration(
              color: CColors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Obx(
                () => Text(
                  controller.noOfCartItems.value.toString(),
                  style: Theme.of(context).textTheme.labelMedium!.apply(color: CColors.white, fontSizeDelta: 0.5),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
