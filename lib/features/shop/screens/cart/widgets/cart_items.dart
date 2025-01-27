import 'package:comro_alt/common/widgets/products/cart/cart_item.dart';
import 'package:comro_alt/common/widgets/products/product_card/product_quantity.dart';
import 'package:comro_alt/common/widgets/texts/product_price_text.dart';
import 'package:comro_alt/features/shop/controllers/cart_controller.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CCartItems extends StatelessWidget {
  const CCartItems({
    super.key,
    this.showRemoveButton = true,
  });

  final bool showRemoveButton;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;

    return Obx(
      () => ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (_, __) => const SizedBox(height: CSizes.spaceBtwSections),
        itemCount: cartController.cartItems.length,
        itemBuilder: (_, index) => Obx(() {
          final item = cartController.cartItems[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //cart item
              CCartItem(cartItem: item),
              if (showRemoveButton) const SizedBox(height: CSizes.spaceBtwItems),

              //add remove button with extra space
              if (showRemoveButton)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        //extra space
                        const SizedBox(width: 60),
                        //add remove button
                        CProductQuantity(
                          quantity: item.quantity,
                          add: () => cartController.addOneToCart(item),
                          remove: () => cartController.removeOneToCart(item),
                        ),
                      ],
                    ),
                    CProductPriceText(
                      currencySign: '',
                      price: (item.price * item.quantity).toStringAsFixed(1),
                    ),
                  ],
                ),
            ],
          );
        }),
      ),
    );
  }
}
