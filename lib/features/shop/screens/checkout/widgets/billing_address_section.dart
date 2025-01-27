import 'package:comro_alt/common/widgets/texts/section_heading.dart';
import 'package:comro_alt/features/personalization/controllers/address_controller.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CBillingAddressSection extends StatelessWidget {
  const CBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = AddressController.instance;
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CSectionHeading(
            title: 'Shipping Address',
            showActionButton: true,
            onPressed: () => addressController.selectNewAddressPopup(context),
          ),
          addressController.selectedAddress.value.id.isNotEmpty
              ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        addressController.selectedAddress.value.name,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: CSizes.spaceBtwItems / 2),
                      Row(
                        children: [
                          const Icon(Icons.phone, size: 16),
                          const SizedBox(width: CSizes.spaceBtwItems),
                          Text(
                            addressController.selectedAddress.value.phoneNumber,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      const SizedBox(height: CSizes.spaceBtwItems / 2),
                      Row(
                        children: [
                          const Icon(Icons.location_city, size: 16),
                          const SizedBox(width: CSizes.spaceBtwItems),
                          Text(
                            addressController.selectedAddress.value.street,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ],
                  )
              : Text(
                  'Select address',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
        ],
      ),
    );
  }
}
