import 'package:comro_alt/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:comro_alt/features/personalization/controllers/address_controller.dart';
import 'package:comro_alt/features/personalization/models/address_model.dart';
import 'package:comro_alt/utils/constants/colors.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CSingleAddress extends StatelessWidget {
  const CSingleAddress({
    super.key,
    required this.address,
    required this.onTap,
  });

  final AddressModel address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    final dark = CHelperFunctions.isDarkMode(context);
    return Obx(() {
      final selectedAddressId = controller.selectedAddress.value.id;
      final selectedAddress = selectedAddressId == address.id;
      return InkWell(
        onTap: onTap,
        child: CRoundedContainer(
          padding: const EdgeInsets.all(CSizes.md),
          width: double.infinity,
          showBorder: true,
          backgroundColor: selectedAddress ? CColors.primary.withOpacity(0.5) : Colors.transparent,
          borderColor: selectedAddress
              ? Colors.transparent
              : dark
                  ? CColors.darkerGrey
                  : CColors.grey,
          margin: const EdgeInsets.only(bottom: CSizes.spaceBtwItems),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 5,
                child: Icon(
                  selectedAddress ? Iconsax.tick_circle5 : null,
                  color: selectedAddress
                      ? dark
                          ? CColors.light.withOpacity(0.6)
                          : CColors.dark.withOpacity(0.6)
                      : null,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: CSizes.xs),
                  Text(
                    address.formattedPhoneNumber,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: CSizes.xs),
                  Text(
                    address.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
