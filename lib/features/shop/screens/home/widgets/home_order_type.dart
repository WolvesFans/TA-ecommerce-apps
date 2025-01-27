import 'package:comro_alt/common/widgets/custom_shapes/container/home_container.dart';
import 'package:comro_alt/features/admin/screens/login/admin_login.dart';
import 'package:comro_alt/features/shop/screens/store/store.dart';
import 'package:comro_alt/utils/constants/text_strings.dart';
import 'package:comro_alt/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CHomeOrderType extends StatelessWidget {
  const CHomeOrderType({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CHomeContainer(
          title: CText.pickUpTitle,
          subtitle: CText.comingSoon,
          onTap: () {},
          width: CDeviceUtils.getScreenWidth() / 2.3,
        ),
        CHomeContainer(
          title: CText.deliveryTitle,
          subtitle: CText.deliverySubtitle,
          icon: Iconsax.truck_fast,
          onTap: () => Get.to(() => const StoreScreen()),
          width: CDeviceUtils.getScreenWidth() / 2.3,
        ),
      ],
    );
  }
}
