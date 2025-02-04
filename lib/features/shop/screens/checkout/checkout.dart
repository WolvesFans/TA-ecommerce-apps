import 'package:comro_alt/common/widgets/appbar/appbar.dart';
import 'package:comro_alt/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:comro_alt/common/widgets/texts/product_price_text.dart';
import 'package:comro_alt/features/personalization/controllers/address_controller.dart';
import 'package:comro_alt/features/shop/controllers/alt_order_controller.dart';
import 'package:comro_alt/features/shop/controllers/cart_controller.dart';
import 'package:comro_alt/features/shop/controllers/checkout_controller.dart';
import 'package:comro_alt/features/shop/controllers/date_controller.dart';
import 'package:comro_alt/features/shop/controllers/transfer_controller.dart';
import 'package:comro_alt/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:comro_alt/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:comro_alt/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:comro_alt/features/shop/screens/checkout/widgets/billing_date_section.dart';
import 'package:comro_alt/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:comro_alt/utils/constants/colors.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/helpers/helper_functions.dart';
import 'package:comro_alt/utils/helpers/pricing_calculator.dart';
import 'package:comro_alt/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:comro_alt/features/shop/screens/checkout/widgets/billing_transfer_section.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    final totalAmount = CPricingCalculator.calculateTotalPrice(subTotal, 'ID');
    final addressControlller = AddressController.instance;
    final dateController = DateController.instance;
    final altOrderController = Get.put(AltOrderController());
    final checkoutController = Get.put(CheckoutController());
    final transferController = Get.put(TransferController());
    return Scaffold(
      appBar: CAppBar(
        showBackArrow: true,
        title: Text(
          'Checkout',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            children: [
              //items in cart
              const CCartItems(showRemoveButton: false),
              const SizedBox(height: CSizes.spaceBtwSections),

              //coupon textfield
              // const CCouponCode(),
              // const SizedBox(height: CSizes.spaceBtwSections),

              //billing section
              CRoundedContainer(
                padding: const EdgeInsets.all(CSizes.md),
                showBorder: true,
                backgroundColor: dark ? CColors.dark : CColors.light,
                child: Column(
                  children: [
                    //pricing
                    const CBillingAmountSection(),

                    //divider
                    const Divider(),

                    //payment methods
                    const CBillingPaymentSection(),
                    const SizedBox(height: CSizes.spaceBtwItems),

                    //divider
                    const Divider(),

                    //address
                    const CBillingAddressSection(),
                    const SizedBox(height: CSizes.spaceBtwItems),

                    //divider
                    const Divider(),

                    //date
                    const CBillingDateSection(),
                    const SizedBox(height: CSizes.spaceBtwItems),

                    //divider
                    const Divider(),

                    //transfer receipt
                    Obx(() {
                      return checkoutController.selectedPaymentMethod.value.name == 'BCA Transfer (4380191950 a/n Zaki Permadi)'
                          ? const CBillingTransferSection()
                          : const SizedBox(
                              height: CSizes.xs,
                            );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      //checkout button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(CSizes.defaultSpace / 2),
        child: ElevatedButton(
          onPressed: () {
            if (addressControlller.selectedAddress.value.id.isEmpty) {
              CLoaders.warningSnackBar(
                title: 'Empty address',
                message: 'Select shipment address!',
              );
            } else if (dateController.deliveryDateTime.value == null) {
              CLoaders.warningSnackBar(
                title: 'Empty Date',
                message: 'Select shipping date!',
              );
            } else if (subTotal <= 0) {
              CLoaders.warningSnackBar(
                title: 'Empty Cart',
                message: 'Add item in the cart to proceed.',
              );
            } else if (checkoutController.selectedPaymentMethod.value.name == 'BCA Transfer' && transferController.selectedImage == null) {
              CLoaders.warningSnackBar(
                title: 'Empty Transfer Receipt',
                message: 'Upload your transfer receipt to process your order.',
              );
            } else {
              altOrderController.processOrder(totalAmount);
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Checkout '),
              CProductPriceText(
                price: subTotal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
