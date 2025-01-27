import 'package:comro_alt/common/widgets/texts/section_heading.dart';
import 'package:comro_alt/features/shop/controllers/cart_controller.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/helpers/pricing_calculator.dart';
import 'package:flutter/material.dart';

class CBillingAmountSection extends StatelessWidget {
  const CBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    return Column(
      children: [
        const CSectionHeading(
          title: 'Price Amount',
        ),
        const SizedBox(height: CSizes.spaceBtwItems * 1.5),
        //subtotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Subtotal',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              'Rp $subTotal',
              style: Theme.of(context).textTheme.titleLarge,
            )
          ],
        ),
        const SizedBox(height: CSizes.spaceBtwItems / 2),

        //shipping fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Shipping fee',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
              'Rp ${CPricingCalculator.getShippingCost('BDG')}',
              style: Theme.of(context).textTheme.titleSmall,
            )
          ],
        ),
        const SizedBox(height: CSizes.spaceBtwItems),

        //order total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Order total',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              'Rp ${CPricingCalculator.calculateTotalPrice(subTotal, 'BDG')}',
              style: Theme.of(context).textTheme.titleLarge,
            )
          ],
        ),
        const SizedBox(height: CSizes.spaceBtwItems / 2),
      ],
    );
  }
}
