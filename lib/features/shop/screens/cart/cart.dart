import 'package:comro_alt/common/widgets/appbar/appbar.dart';
import 'package:comro_alt/common/widgets/loaders/animation_loader.dart';
import 'package:comro_alt/features/shop/controllers/cart_controller.dart';
import 'package:comro_alt/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:comro_alt/features/shop/screens/checkout/checkout.dart';
import 'package:comro_alt/features/shop/screens/store/store.dart';
import 'package:comro_alt/utils/constants/image_strings.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Scaffold(
      appBar: CAppBar(
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),
      body: Obx(
        () {
          //nothing found in widget
          final emptyWidget = CAnimationLoaderWidget(
            text: 'Cart is empty!',
            animation: CImage.loadingAnimation,
            actionText: 'Let\'s Fill it',
            showAction: true,
            onActionPressed: () => Get.off(() => const StoreScreen()),
          );

          if (controller.cartItems.isEmpty) {
            return emptyWidget;
          } else {
            return const SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(CSizes.defaultSpace),

                //items in cart
                child: CCartItems(),
              ),
            );
          }
        },
      ),

      //checkout button
      bottomNavigationBar: controller.cartItems.isEmpty
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(CSizes.defaultSpace / 2),
              child: ElevatedButton(
                onPressed: () => Get.to(() => const CheckoutScreen()),
                child: const Text(
                  'Checkout',
                ),
              ),
            ),
    );
  }
}