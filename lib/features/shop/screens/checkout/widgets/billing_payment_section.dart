import 'package:comro_alt/common/widgets/images/rounded_image.dart';
import 'package:comro_alt/common/widgets/texts/section_heading.dart';
import 'package:comro_alt/features/shop/controllers/checkout_controller.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CBillingPaymentSection extends StatelessWidget {
  const CBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckoutController());
    return Column(
      children: [
        CSectionHeading(
          title: 'Payment Methods',
          showActionButton: true,
          buttonTitle: 'Change',
          onPressed: () => controller.selectPaymentMethod(context),
        ),
        const SizedBox(height: CSizes.spaceBtwItems / 2),
        Obx(
          () => Row(
            children: [
              CRoundedImage(
                imageUrl: controller.selectedPaymentMethod.value.image,
                height: 50,
                width: 50,
                applyImageRadius: true,
              ),
              const SizedBox(width: CSizes.spaceBtwItems),
              Text(
                controller.selectedPaymentMethod.value.name,
                style: Theme.of(context).textTheme.titleLarge,
              )
            ],
          ),
        )
      ],
    );
  }
}
