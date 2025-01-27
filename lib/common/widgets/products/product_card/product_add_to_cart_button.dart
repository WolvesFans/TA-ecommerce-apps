import 'package:comro_alt/features/shop/controllers/cart_controller.dart';
import 'package:comro_alt/features/shop/models/product_model.dart';
import 'package:comro_alt/utils/constants/colors.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProductAddToCartButton extends StatefulWidget {
  const ProductAddToCartButton({
    super.key,
    this.applyAddButton = true,
    required this.product,
  });

  final ProductModel product;
  final bool applyAddButton;

  @override
  State<ProductAddToCartButton> createState() => _ProductAddToCartButtonState();
}

class _ProductAddToCartButtonState extends State<ProductAddToCartButton> {
  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return GestureDetector(
      onTap: () {
        final cartItem = cartController.convertToCartItem(widget.product, 1);
        cartController.addOneToCart(cartItem);
      },
      child: Obx(() {
        final productQuantityInCart = cartController.getProductQuantityInCart(widget.product.id);
        return Container(
          decoration: BoxDecoration(
            color: CColors.black,
            borderRadius: BorderRadius.circular(100),
          ),
          child: SizedBox(
            width: CSizes.iconLg,
            height: CSizes.iconLg,
            child: Center(
              child: productQuantityInCart > 0
                  ? Text(
                      productQuantityInCart.toString(),
                      style: const TextStyle(color: CColors.white),
                    )
                  : const Icon(
                      Iconsax.add,
                      color: CColors.white,
                    ),
            ),
          ),
        );
      }),
    );
  }
}
