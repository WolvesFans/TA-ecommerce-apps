import 'package:comro_alt/features/shop/screens/home/our_history/our_history_container.dart';
import 'package:comro_alt/common/widgets/custom_shapes/container/home_container.dart';
import 'package:comro_alt/utils/constants/text_strings.dart';
import 'package:comro_alt/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class COurHistory extends StatelessWidget {
  const COurHistory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CHomeContainer(
      title: CText.ourHistorytitle,
      subtitle: CText.ourHistorySubtitle,
      icon: Iconsax.text_block,
      width: CDeviceUtils.getScreenWidth() / 2.3,
      onTap: () => Get.to(() => const COurHistoryContainer()),
    );
  }
}
